require "spec_helper"
describe Lita::Handlers::HipchatExtensions::Fetcher, lita_handler: true do

  # Events
  it { routes_event(:connected).to(:sync)                }
  it { routes_event(:synchronize).to(:sync_user)         }
  # Commands
  it { routes_command("hc show @mention_name").to(:show) }

  describe "#show" do
    pending
  end

  describe "#sync" do
    pending
  end

  describe "#sync_user" do
    pending
  end
end
