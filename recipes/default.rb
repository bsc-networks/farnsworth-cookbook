# Cookbook Name:: farnsworth
# Recipe:: default
#
# Copyright 2014, Nicholas Herson, Berkeley Student Cooperative #
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum'
include_recipe 'java'
include_recipe 'python'
include_recipe 'apache2'
if node[:farnsworth][:ssl_enabled]
  include_recipe 'apache2::mod_ssl'
end
include_recipe 'apache2::mod_wsgi'
include_recipe 'simple_iptables'
include_recipe 'postgresql'
include_recipe 'postgresql::server'
include_recipe 'database'
include_recipe 'database::postgresql'
include_recipe 'git'

# Setup elasticsearch repo
if node[:platform] == 'centos'
  include_recipe 'selinux'
  yum_repository "elasticsearch" do
    description "Source for Elasticsearch packages"
    baseurl "http://packages.elasticsearch.org/elasticsearch/0.90/centos"
    gpgkey "http://packages.elasticsearch.org/GPG-KEY-elasticsearch"
    action :create
  end
elsif node[:platform] == 'ubuntu'
  apt_repository 'elasticsearch' do
    uri          'http://packages.elasticsearch.org/elasticsearch/0.90/debian'
    distribution 'stable'
    components   ['main']
    key          'http://packages.elasticsearch.org/GPG-KEY-elasticsearch'
  end
end

package 'elasticsearch'

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

simple_iptables_rule "http" do
  rule "--proto tcp --dport 80"
  jump "ACCEPT"
end

if node[:farnsworth][:ssl_enabled]
  simple_iptables_rule "http" do
    rule "--proto tcp --dport 443"
    jump "ACCEPT"
  end
end

superuser_postgresql_connection = {
  :host => 'localhost',
  :username => 'postgres',
  :password => node[:postgresql][:password][:postgres]
}

postgresql_database farns_db do
  connection(
    :host => '127.0.0.1',
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
  owner node[:apache][:user]
  group node[:apache][:group]
  repository node[:farnsworth][:repo]
  revision node[:farnsworth][:app_version]
  migrate true
  django do
    settings_template 'house_settings.py.erb'
    local_settings_file 'farnsworth/house_settings.py'
    collectstatic true
  end
end

# Apache VHost definition
if node[:farnsworth][:ssl_enabled]
  web_app 'farnsworth' do
    cookbook 'farnsworth'
    template 'farnsworth_vhost.ssl.conf.erb'
    enable true
  end
else
  web_app 'farnsworth' do
    cookbook 'farnsworth'
    template 'farnsworth_vhost.conf.erb'
    enable true
  end
end
