module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Handles Timezone shenanigans
      class Timezone < Base
        route /^tz\s+(@\w+)/, :show, command: true
        route /^tz\s+list/,   :list, command: true

        # TODO: Document me
        def show(response)
          log.info "Timezone#show"
          mention_name = response.args.first.gsub "@", ""
          response.reply t("timezones.show.usage") and return unless mention_name
          user = Lita::User.fuzzy_find(mention_name)
          response.reply "#{mention_name}'s timezone is #{format_timezone(user.metadata["timezone"])}" 
        end

        def whenis(response)

        end

        def list(response)
          log.info "Timezone#list"
          response.reply lita_users.map { |u| u.metadata["timezone"] }.uniq.sort
        end

        protected

        def fetch_time(user, time, target)
          user   = Lita::User.fuzzy_find(user)
          target = Lita::User.fuzzy_find(target)
          # Fetch the timezones
          tz_user   = ActiveSupport::TimeZone[ fetch_timezone(user)   ]
          tz_target = ActiveSupport::TimeZone[ fetch_timezone(target) ]
          # Check that we have them
          raise "Nope" unless tz_user && tz_target
          Time.zone = tz_user
          # Parse the time locally
          user_time = time == "now" ? Time.zone.now : Time.zone.parse(time)
          # Move the time to the target's tz
          target_time = user_time.in_time_zone(tz_target)
        end

        # TODO: Document me
        def format_timezone(timezone)
          tz = ActiveSupport::TimeZone[ timezone ]
          "GMT#{tz.formatted_offset[0..2].to_i}"
        end

        # TODO: Document me
        def format_time(time)
          time.strftime("%I:%M%P")
        end
      end
      Lita.register_handler(Timezone)
    end
  end
end