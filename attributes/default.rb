default[:farnsworth][:house_name] = 'Davis House'
default[:farnsworth][:short_house_name] = 'Davis'
default[:farnsworth][:house_abbrev] = 'dav'
default[:farnsworth][:site_domain] = 'davis.house'

default[:farnsworth][:enable_oauth] = false
default[:farnsworth][:oauth_providers] = []

default[:farnsworth][:repo] = 'https://github.com/nherson/farnsworth.git'

# path on the host where the secret key for the (farnsworth, private)
# encrypted data bag item lives
# default: /etc/chef/keys/farnsworth_private.key
default[:farnsworth][:key_path] = '/etc/chef/keys/farnsworth_private.key'

#default[:farnsworth][:pip_dependencies] = [ 
#    'django',
#    'django-bootstrap-form',
#    'python-social-auth',
#    'psycopg2' 
#  ]


default[:farnsworth][:site_root] = '/usr/local/farnsworth'

# Do not change the lines below this comment!
#if node[:platform] == 'centos'
#  default[:selinux][:booleans][:httpd_can_network_connect_db] = 'on'
#  default[:selinux][:booleans][:httpd_can_network_connect] = 'on'
#end
default[:selinux][:state] = 'permissive'
