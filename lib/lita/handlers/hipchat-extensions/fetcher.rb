module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Fetches and persists info from the Hipchat API
      class Fetcher < Base
        # Events
        on :connected, :synchronize

        # Routes

        # #show
        route /^hc\s+show\s+(@\w+)/, :show, command: true, help: { 
         t("fetcher.show.help.key") => t("fetcher.show.help.value")
        }

        route /^hc\s+sync/, :sync, command: true, help: {
          t("fetcher.sync.help.key") =>  t("fetcher.sync.help.value")
        }

        # Shows Hipchat API information about a given user
        def show(response)
          # Don't do anything unless we are enabled
          return unless enabled?
          wrapping_errors(response) do
            # Lita::Users are stored with their mention_name which doesn't have
            # the @ sign, there may be a more Lita friendly way of figuring that
            # out.
            mention_name = extract_name(response.args[1])
            # We need this to proceed
            response.reply "#{t("fetcher.show.help.key")} : #{t("fetcher.show.help.value")}" and return unless mention_name
            # Find by ID or email or mention name
            user         = Lita::User.fuzzy_find mention_name
            # Reply with the metadata
            response.reply user.metadata.inspect
          end
        end

        # Discovers and synchronizes additional Hipchat info for each user
        def synchronize(payload={})
          return unless enabled?
          wrapping_errors do
            fetch_users.each do |json|
              # Call .async so we multithread
              Synchronizer.new(token, json).async.synchronize
            end
          end
        end

      end
      Lita.register_handler(Fetcher)
    end
  end
end