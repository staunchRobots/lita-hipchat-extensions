module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Fetches and persists info from the Hipchat API
      class Fetcher < Base
        on :connected,   :sync
        on :synchronize, :sync_user

        route /^hc\s+show\s+(@\w+)/, :show, command: true

        # TODO: Document me
        def show(response)
          mention_name = response.args[1].gsub "@", ""
          response.reply t("fetcher.show.usage") and return unless mention_name
          user         = Lita::User.fuzzy_find mention_name
          response.reply user.metadata.inspect
        end

        # Discovers and synchronizes additional Hipchat info for each user
        def sync(payload)
          fetch_users.each do |json|
            name    = json["mention_name"]
            robot.trigger :synchronize, json
          end
        end

        # Synchronizes each user complementing Lita::User metadata with API stuff.
        def sync_user(json)
          log.info "Checking if #{json["mention_name"]} needs synchronization..."
          user = Lita::User.fuzzy_find(json["mention_name"])
          return if user.metadata.has_key?("timezone")
          log.info "Synchronizing #{user.name}"
          payload.merge! fetch_user(json["id"])
          log.debug user.metadata.merge! json
          log.info  user.save
        end

      end
      Lita.register_handler(Fetcher)
    end
  end
end