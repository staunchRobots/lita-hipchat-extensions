module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Handles Timezone shenanigans
      class Timezone < Base

      end
      Lita.register_handler(Timezone)
    end
  end
end