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
        response = get_response
        response.success?.should be_true
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

    it "should rescue a timeout error" do
      stub_request(:get, "http://www.zillow.com/webservice/GetRegionChildren.htm?state=CA&zws-id=#{ZWS_ID}").to_timeout
      response = get_response
      response.success?.should be_false
      response.message.should_not be_nil
      response.message.code.should == "3"
      response.response_code.should == 3
    end
  end

end
