name             'razor'
maintainer       'Stephan Renatus'
maintainer_email 's.renatus@cloudbau.de'
license          'All rights reserved'
description      'Installs/Configures razor'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'postgresql'
depends 'database'
depends 'rbenv'
depends 'java' # jruby!!
