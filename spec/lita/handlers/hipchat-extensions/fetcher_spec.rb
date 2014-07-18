require "spec_helper"
module Lita::Handlers
  class HipchatExtensions

    describe Fetcher, lita_handler: true do

      # Premises
      let(:user)  { double :name => "foo", :metadata => { "foo" => "bar" } }
      let(:users) { [{ "mention_name" => "foo" }] }

      # Stubs
      before do
        allow_any_instance_of(::Hipchat).to receive(:users).and_return(users)
        allow_any_instance_of(::Hipchat).to receive(:user).and_return(user)
        allow(Lita::User).to receive(:fuzzy_find).and_return(user)
        allow_any_instance_of(Synchronizer).to receive_message_chain(:async, :synchronize).and_return(true)
      end

      # Events
      it { routes_event(:connected).to(:synchronize)         }

      # Commands
      it { routes_command("hc show @mention_name").to(:show) }
      it { routes_command("hc sync").to(:sync)               }

      describe "#show" do
        it "replies with the user's metadata" do
          send_command("hc show @foo")
          expect(replies.last).to eq user.metadata.inspect
        end
      end #/show

      describe "#synchronize" do
        
      end #/sync

    end #/Fetcher

  end
end
