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
        end

        # Instance Methods

          # @return [String] the auth token for accessing Hipchat's API
          def token
            config.token
          end

        # @return [Hipchat] the hipchat client used to make calls to the API
        def client
          @client ||= ::Hipchat.new(token)
        end

        def lita_users
          @users ||= fetch_users.map { |u| Lita::User.fuzzy_find u["mention_name"] }
        end

        def fetch_users
          @users ||= client.users
        end

        def fetch_users_in_room

        end

        def fetch_user(id)
          client.user(id)
        end

      end # /Base
    end
  end
end