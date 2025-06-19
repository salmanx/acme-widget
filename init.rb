##  Acme Widget Co  ###

# Guide
# ----------
# Entry-point controller class that handles user interaction.
# Loads products from a CSV file and manages commands like listing products,
# adding items to basket, and showing delivery rules.

# Launch this from command line to get started
# ruby init.rb

require 'bigdecimal'
require 'bigdecimal/util'

APP_ROOT = File.dirname(__FILE__)

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'core/guide'

guide = Guide.new('data/products.csv')
guide.launch!
