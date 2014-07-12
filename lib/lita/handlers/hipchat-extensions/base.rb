module Lita
  module Handlers
    class HipchatExtensions < Handler
      class Base < Handler
        # Default Configuration
        def self.default_config(config)
          config.token  = "qRj4AYVzKb5yWcM3TyNSUbpE7CQrTTGwqdyZkLPF"
        end

        # @return [String] The auth token for accessing Hipchat's API
        def self.token
          config.token
        end
      end
    end
  end
end