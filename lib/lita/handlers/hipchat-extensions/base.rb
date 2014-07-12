module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Base class for all extension handlers
      class Base < Handler

        # Class Methods
        class << self
          # Custom name so all handlers share the same redis namespace
          def name
            "hipchat-extensions"
          end

          # @return [String] the auth token for accessing Hipchat's API
          def token
            config.token
          end
        end

        # Instance Methods

        # @see Base.token
        def token
          self.class.token
        end

        # @return [Hipchat] the hipchat client used to make calls to the API
        def client
          @client ||= ::Hipchat.new(token)
        end

      end # /Base
    end
  end
end