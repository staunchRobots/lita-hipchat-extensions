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
    let(:users) { [{ "mention_name" => "foo" }] }
    before do
      allow(subject).to receive(:fetch_users).and_return(users)
    end
    it "triggers synchronize for each item in the fetch_users array" do
      users.each do |user|
        expect(robot).to receive(:trigger).with(:synchronize, user)
        subject.sync
      end
    end
  end

  describe "#sync_user" do
    pending
  end
end
