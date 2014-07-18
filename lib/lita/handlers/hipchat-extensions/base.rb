module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Base class for all extension handlers
      class Base < Handler

        # Class Methods
        class << self

          # Default configuration
          def default_config(config)
            config.token   = nil
            config.enabled = true
          end

          # Custom name so all handlers share the same redis namespace
          def name
            "hipchat-extensions"
          end

        end

        # Instance Methods

        # @return [String] the authentication token for accessing Hipchat's API
        def token
          config.token
        end

        # @return [true/false] is this handler enabled?
        def enabled?
          !!config.enabled
        end

        # Wraps a block catching errors and logging / replying to the source,
        # when they happen before re-raising them
        def wrapping_errors(response=nil, &block)
          begin
            yield if block_given?
          rescue StandardError => e
            "Oh noes, #{e.message}".tap do |message|
              log.error message
              response.reply message if response
            end
            e.backtrace.each { |t| e.debug t }
            raise e
          end
        end

        def extract_name(name)
          name.gsub "@", ""
        end

        # @return [Hipchat] the hipchat client instance used to make calls to the API
        def client
          @client ||= ::Hipchat.new(token)
        end

        # @return [Array<Lita::User>] a collection of Lita::Users
        # TODO: Make this a hash with the mention names as keys
        def lita_users
          @lita_users ||= fetch_users.inject({}) do |hash, u| 
            hash.merge u["mention_name"] => Lita::User.fuzzy_find(u["mention_name"])
          end
        end

        # @return [Array<Hash>] an array of user's metadatas
        def fetch_users
          @users ||= client.users
        end

        # Fetches info about a single user
        # @param id 
        #     the user's API ID
        # @return [Hash]
        #     the user's metadata
        def fetch_user(id)
          client.user(id)
        end

      end # /Base
    end
  end
end