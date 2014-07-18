require "lita"
require "httparty"
require "active_support"
require "active_support/all"
require "celluloid"
require "utils/relative_distances"
require "hipchat"
Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/hipchat-extensions"
require "lita/handlers/hipchat-extensions/base"
require "lita/handlers/hipchat-extensions/synchronizer"
require "lita/handlers/hipchat-extensions/fetcher"
require "lita/handlers/hipchat-extensions/timezone"
