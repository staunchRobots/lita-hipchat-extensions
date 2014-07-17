require "spec_helper"
describe Lita::Handlers::HipchatExtensions::Fetcher, lita_handler: true do

  # Events
  it { routes_event(:connected).to(:sync)                }
  it { routes_event(:synchronize).to(:sync_user)         }

  # Commands
  it { routes_command("hc show @mention_name").to(:show) }
  it { routes_command("hc sync").to(:sync)               }

  describe "#show" do
    let(:user) { double :name => "foo", :metadata => { "foo" => "bar" } }

    before do
      allow(Lita::User).to receive(:fuzzy_find).with("foo").and_return(user)
    end

    it "replies with the user's metadata" do
      send_command("hc show @foo")
      expect(replies.last).to eq user.metadata.inspect
    end
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
    let(:json) { { "mention_name" => "foo", "id" => 1, 
      "timezone" => "America/Sao_Paulo"} }
    let(:user) { double :metadata => {}, :save => true, :name => "foo" }

    before do
      allow(subject).to receive(:fetch_user).with(json["id"]).and_return(json)
      allow(Lita::User).to receive(:fuzzy_find).and_return(user)
    end

    it "merges the metadata to the Lita::User's metadata" do
      subject.sync_user(json)
      expect(user.metadata.keys.sort).to eq json.keys.sort
    end

    it "saves the user" do
      expect(user).to receive(:save)
      subject.sync_user(json)
    end
  end
end
