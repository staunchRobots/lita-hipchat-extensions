module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Handles Timezone shenanigans
      class Timezone < Base
        route /^tz\s+(@\w+)/, :show, command: true

        # TODO: Document me
        def show(response)
          mention_name = response.args.first.gsub "@", ""
          response.reply t("timezones.show.usage") and return unless mention_name
          user = Lita::User.fuzzy_find(mention_name)
          response.reply "#{mention_name}'s timezone is #{format_timezone(user.metadata["timezone"])}" 
        end

        protected

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