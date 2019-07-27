require 'spec_helper'

describe Zester::Resource do
  let!(:zester) {new_zester}
  let!(:resource) {Zester::Resource.new(zester)}

  it "should instantiate with a client" do
    resource.client.should_not be_nil
  end

  context "get_results" do
    it "should return a response" do
      VCR.use_cassette('resource') do
        response = resource.get_results('GetRateSummary', :rate_summary)
        response.should be_instance_of(Zester::Response)
      end
    end
  end

  context "timeout error" do
    before(:all) do
      VCR.turn_off!
    end

    after(:all) do
      VCR.turn_on!
    end

    it "should not rescue a timeout error" do
      stub_request(:get, "http://www.zillow.com/webservice/GetRateSummary.htm?zws-id=#{ZWS_ID}").to_timeout
      expect {get_response}.to raise_error(Timeout::Error)
    end
  end

end
