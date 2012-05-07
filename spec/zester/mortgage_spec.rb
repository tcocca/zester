require 'spec_helper'

describe Zester::Mortgage do
  let!(:zester) {new_zester}
  let!(:mortgage) {zester.mortgage}

  context "rate_summary" do
    it "should be a success" do
      VCR.use_cassette('mortgage') do
        response = mortgage.rate_summary
        response.success?.should be_true
        response.today.should_not be_nil
        response.last_week.should_not be_nil
      end
    end

    it "should be a failure" do
      VCR.use_cassette('mortgage') do
        response = mortgage.rate_summary('XZ')
        response.success?.should be_false
        response.response_code.should ==  501
        response.error_message.should_not be_nil
        response.should_not respond_to(:today)
        response.should_not respond_to(:last_week)
      end
    end
  end

end
