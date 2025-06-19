###  Acme Widget Co  ###

# Launch this from command line to get started
# ruby init.rb

require 'bigdecimal'
require 'bigdecimal/util'

APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'core/guide'

guide = Guide.new('data/products.csv')
guide.launch!
