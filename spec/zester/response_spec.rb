require 'spec_helper'

describe Zester::Response do
  let!(:zester) {new_zester}
  let!(:resource) {Zester::Resource.new(zester)}

  it "should return a success" do
    VCR.use_cassette('response') do
      response = resource.get_results('GetRateSummary', :rate_summary)
      response.success?.should be_true
      response.message.should_not be_nill
      response.message.code.should == "0"
    end
  end

  it "should return a failure" do
    VCR.use_cassette('response') do
      response = resource.get_results('GetRateSummary', :rate_summary, {:state => 'XZ'})
      response.success?.should be_false
      response.error_message.should_not be_nil
      response.message.code.should == "501"
    end
  end

  context "method_missing" do
    it "should call methods off of the body.response" do
      VCR.use_cassette('response') do
        response = resource.get_results('GetRateSummary', :rate_summary)
        response.body.response.today.should == response.today
      end
    end
  end

end
