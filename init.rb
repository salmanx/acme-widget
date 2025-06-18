###  Acme Widget Co  ###

# Launch this from command line
# to get started

APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'guide'

guide = Guide.new('data/products.csv')
guide.launch!
