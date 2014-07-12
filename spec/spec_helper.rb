require "simplecov"
require "coveralls"
require "pry-byebug"
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start { add_filter "/spec/" }

require "lita-hipchat-extensions"
require "lita/rspec"
