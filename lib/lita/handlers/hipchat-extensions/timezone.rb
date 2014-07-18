module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Handles Timezone shenanigans
      class Timezone < Base
        include RelativeDistances

        route /^tz\s+(@\w+)/,      :show, command: true
        route /^tz\s+list/,        :list, command: true
        route /^tz\s+when\s+(.*)/, :when, command: true
        route /^ls\s+(.*)/,   :last_seen, command: true

        # TODO: Document me
        def show(response)
          return unless enabled?
          mention_name = response.args.first.gsub "@", ""
          response.reply t("timezones.show.usage") and return unless mention_name
          user = Lita::User.fuzzy_find(mention_name)
          response.reply "#{mention_name}'s timezone is #{format_timezone(user.metadata["timezone"])}" 
        end

        # TODO: Document me
        def when(response)
          return unless enabled?
          time = response.args[1]
          response.reply ("timezone.when.usage") and return unless time
          Time.zone    = current_timezone(response)
          current_time = time == "now" ? Time.zone.now : Time.zone.parse(time)
          user_timezones.each do |tz|
            converted_time = current_time.in_time_zone(ActiveSupport::TimeZone[tz])
            response.reply "#{tz}: #{format_time(converted_time)}"
          end
        end

        # Responds with a human friendly translation on how long ago this user 
        # was last active
        def last_seen(response)
          return unless enabled?
          name = extract_name(response.args[0])
          response.reply t("timezones.last_seen.usage") and return unless name
          # Get the latest info
          ago  = time_ago_in_words(Time.now, Time.at(last_active(name)) )
          response.reply "#{name} was last seen #{ago} ago."
        end

        # TODO: Document me
        def list(response)
          response.reply user_timezones
        end

        protected

        def user_timezones
          lita_users.map { |u| u.metadata["timezone"] }.uniq.sort
        end

        def current_timezone(response)
          fetch_timezone(response.user.mention_name)
        end

        def last_active(mention_name)
          id = Lita::User.fuzzy_find(mention_name).metadata["id"]
          return nil unless id
          client.user(id)["last_active"].to_i
        end

        def fetch_timezone(mention_name)
          ActiveSupport::TimeZone[ Lita::User.fuzzy_find(mention_name).metadata["timezone"] ]
        end

        def fetch_time(source_tz, target_tz)
          # Fetch the timezones
          tz_source = fetch_timezone(source)
          tz_target = fetch_timezone(target)
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