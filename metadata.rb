name             'razor'
maintainer       'x-ion GmbH'
maintainer_email 'j.klare@x-ion.de'
license          'All rights reserved'
description      'Installs/Configures razor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'postgresql'
depends 'database'
depends 'rbenv'
depends 'java' # jruby!!
depends 'runit'
depends 'dnsmasq'
