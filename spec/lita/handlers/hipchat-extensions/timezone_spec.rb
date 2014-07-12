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
    it "responds with a group of unique timezones" do
      binding.pry
      expect(subject.user_timezones).to be_a Array
    end
  end
end
