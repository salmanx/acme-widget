###  Acme Widget Co  ###

# Launch this from command line to get started
# ruby init.rb

APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'guide'

guide = Guide.new('data/products.csv')
guide.launch!
