require 'spec_helper'

describe Hipchat do
  let(:token) { "chalala" }
  subject     { described_class.new token }

  before do
    allow(described_class).to receive(:get).and_return(response)
  end

  describe "#users" do
    let(:response) do
      double("Response", :parsed_response => { "items" => [{}, {}] })
    end

    it "returns an array" do
      expect(subject.users).to(be_a Array)
    end

    context "each item in the array" do
      let(:item) { subject.users.first }
      it "is a Hash" do
        expect(item).to(be_a Hash)
      end
    end
  end

  describe "#user" do
    let(:response) do
      double("Response", :parsed_response => {})
    end
    it "returns a Hash" do
      expect(subject.user("chalala")).to(be_a Hash)
    end
  end

end