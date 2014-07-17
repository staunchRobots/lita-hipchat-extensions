require "spec_helper"
describe Lita::Handlers::HipchatExtensions::Fetcher, lita_handler: true do

  # Events
  it { routes_event(:connected).to(:sync)                }
  it { routes_event(:synchronize).to(:sync_user)         }

  # Commands
  it { routes_command("hc show @mention_name").to(:show) }
  it { routes_command("hc sync").to(:sync)               }

  # Premises
  let(:user)  { double :name => "foo", :metadata => { "foo" => "bar" } }
  let(:users) { [{ "mention_name" => "foo" }] }

  before do
    allow(Lita::User).to receive(:fuzzy_find).and_return(user)
  end

  describe "#show" do
    it "replies with the user's metadata" do
      send_command("hc show @foo")
      expect(replies.last).to eq user.metadata.inspect
    end
  end #/show

  describe "#synchronize" do
    pending
  end #/sync

end
