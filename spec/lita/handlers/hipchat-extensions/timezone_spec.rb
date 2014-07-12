require "spec_helper"

describe Lita::Handlers::HipchatExtensions::Timezone, lita_handler: true do
  it { routes_command("tz @mention_name").to(:show) }

  describe "#show" do
    pending
  end

  describe "#list" do
    pending
  end

  describe "#user_timezones" do
    pending
  end
end
