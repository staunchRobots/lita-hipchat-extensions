module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Synchronizes User Metadata info asynchronusly (if you want to)
      class Synchronizer
        include Celluloid

        attr_accessor :client
        attr_accessor :token
        attr_accessor :logger
        attr_accessor :metadata

        def initialize(token, json = {})
          @token    = token
          @metadata = json
        end

        def client
          @client ||= ::Hipchat.new(token)
        end

        def logger
          @logger ||= ::Logger.new("./hipchat.log")
        end

        def name
          metadata["mention_name"]
        end

        def id
          metadata["id"]
        end

        def synchronize
          logger.info "Synchronizing #{name}..."
          user = Lita::User.fuzzy_find(name)
          metadata.merge! client.user(id)
          logger.debug user.metadata.merge! metadata
          logger.info "Synchronized #{name}!"
        end

      end # /Synchronizer
    end
  end
end
