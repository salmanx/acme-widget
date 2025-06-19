require 'rspec'
require 'bigdecimal'
require 'bigdecimal/util'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'core'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'helpers'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'offers'))

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
