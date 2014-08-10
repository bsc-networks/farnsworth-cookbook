name             'farnsworth'
maintainer       'Nicholas Herson'
maintainer_email 'nicholas.herson@gmail.com'
license          'All rights reserved'
description      'Installs/Configures farnsworth'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.1'

depends 'yum'
depends 'java'
depends 'python'
depends 'apache2'
depends 'postgresql'
depends 'database'
depends 'simple_iptables'
depends 'application_python'
depends 'selinux'
depends 'git'
