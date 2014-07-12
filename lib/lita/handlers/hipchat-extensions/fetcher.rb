module Lita
  module Handlers
    class HipchatExtensions < Handler
      # Fetches and persists info from the Hipchat API
      class Fetcher < Base

        def fetch_all(response)

        end
      end
      Lita.register_handler(Fetcher)
    end
  end
end