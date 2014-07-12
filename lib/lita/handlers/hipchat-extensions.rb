module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Default Configuration
      def self.default_config(config)
        config.token  = "qRj4AYVzKb5yWcM3TyNSUbpE7CQrTTGwqdyZkLPF"
      end
    end
    Lita.register_handler(HipchatExtensions)
  end
end