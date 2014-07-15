# Cookbook Name:: farnsworth
# Recipe:: default
#
# Copyright 2014, Nicholas Herson, Berkeley Student Cooperative
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'
include_recipe 'python'
include_recipe 'apache2'
include_recipe 'postgresql::server'
include_recipe 'database'
include_recipe 'database::postgresql'
include_recipe 'elasticsearch'
include_recipe 'mercurial'
include_recipe 'git'


if node[:platform] == 'centos'
  include_recipe 'selinux'
  app_packages = ['gcc', 'mod_wsgi']
elsif node[:platform] == 'debian'
  app_packages = ['gcc', 'libapache2-mod-wsgi']
end

secret = Chef::EncryptedDataBagItem.load_secret(node[:farnsworth][:key_path])
private_bits = Chef::EncryptedDataBagItem.load("farnsworth", "private", secret)

# django app user and db user
farns_db = node[:farnsworth][:short_house_name].downcase
farns_user = farns_db + '_admin'

user farns_user do
  system true
  #gid farns_user
  shell '/sbin/nologin'
  action :create
end

# ensure elasticsearch is running
service 'elasticsearch' do
  action :enable
end

# make sure the app repo is setup
#git 'farnsworth' do
#  action :checkout
#  destination node[:farnsworth][:site_root]
#  user farns_user
#  group farns_user
#end

# place the config
#template 'farnsworth_config' do
#  source 'house_settings.py.erb'
#  path "#{node[:farnsworth][:site_root]}/farnsworth/house_settings.py"
#  owner farns_user
#  group farns_user
#end

#python_virtualenv node[:site_root] do
#  owner farns_user
#  group farns_user
#  action :create
#end

# install the farnsworth pip dependencies
#node[:farnsworth][:pip_dependencies].each do |depend|
#  python_pip depend do
#    virtualenv node[:farnsworth][:site_root]
#  end
#end

python_virtualenv "/usr/local/farnsworth/shared/env" do
  owner "davis-admin"
  group "davis-admin"
  action :create
end

python_pip "django-weekday-field" do
  "/usr/local/farnsworth/shared/env"
end

# Apache VHost definition
web_app 'farnsworth' do
  cookbook 'farnsworth'
  template 'farnsworth_vhost.conf.erb'
  enable true
end

superuser_postgresql_connection = {
  :host => 'localhost',
  :username => 'postgres',
  :password => node[:postgresql][:password][:postgres]
}

postgresql_database farns_db do
  connection(
    :host => 'localhost',
    :username => 'postgres',
    :password => node[:postgresql][:password][:postgres]
  )
  action :create
end

postgresql_database_user farns_user do
  connection superuser_postgresql_connection
  password private_bits['postgres_password']
  action     :create
end

postgresql_database_user farns_user do
  connection    superuser_postgresql_connection
  database_name farns_db
  privileges    [:all]
  action        :grant
end



application 'farnsworth' do
  path node[:farnsworth][:site_root]
  owner farns_user
  group farns_user
  repository node[:farnsworth][:repo]
  revision 'master'
  packages app_packages
  migrate true
  #symlink_before_migrate "house_settings.py" => "farnsworth/house_settings.py"
  django do
    settings_template 'house_settings.py.erb'
    local_settings_file 'farnsworth/house_settings.py'
    collectstatic true
  end
end

#postgresql_database "EXTRACT_NAME_HERE" do
#  connection(
#    :host => '127.0.0.1',
#    :port => '5432',
#    :username => 'postgres',
#    :password => 'extracted postgres password',
#  )
#end
