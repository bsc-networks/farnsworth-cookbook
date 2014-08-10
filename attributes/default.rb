default[:farnsworth][:house_name] = 'Coop House'
default[:farnsworth][:short_house_name] = 'Coop'
default[:farnsworth][:house_abbrev] = 'coo'
default[:farnsworth][:site_domain] = 'www.coop.house'

default[:farnsworth][:enable_oauth] = false
default[:farnsworth][:oauth_providers] = []

default[:farnsworth][:repo] = 'https://github.com/nherson/farnsworth.git'

# Version of the farnsworth app to install.  Looks for a git tag/release 
# with the same version name
default[:farnsworth][:app_version] = 'v1.2.1_2'

# path on the host where the secret key for the (farnsworth, private)
# encrypted data bag item lives
# default: /etc/chef/keys/farnsworth_private.key
default[:farnsworth][:key_path] = '/etc/chef/keys/farnsworth_private.key'

default[:farnsworth][:site_root] = '/usr/local/farnsworth'

default[:farnsworth][:ssl_enabled] = false

default[:farnsworth][:ssl_cert_file] = '/etc/ssl/server.crt'
default[:farnsworth][:ssl_key_file] = '/etc/ssl/server.key'

# Do not change the lines below this comment!
#if node[:platform] == 'centos'
#  default[:selinux][:booleans][:httpd_can_network_connect_db] = 'on'
#  default[:selinux][:booleans][:httpd_can_network_connect] = 'on'
#end
default[:selinux][:state] = 'permissive'
