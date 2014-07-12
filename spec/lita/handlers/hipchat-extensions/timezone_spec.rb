require "spec_helper"

describe Lita::Handlers::HipchatExtensions::Timezone, lita_handler: true do
  it { routes_command("tz @mention_name").to(:show) }

  describe "#show" do
    pending
  end
end
