require 'spec_helper'

describe Zester::Mortgage do
  let!(:zester) {new_zester}

  context "rate_summary" do
    let!(:mortgage) {zester.mortgage}

    it "should be a success" do
      VCR.use_cassette('mortgage') do
        response = mortgage.rate_summary
        response.success?.should be_true
        response.today.should_not be_nil
      end
    end

    it "should be a failure" do
      VCR.use_cassette('mortgage') do
        response = mortgage.rate_summary('XZ')
        response.success?.should be_false
        response.error_message.should_not be_nil
      end
    end
  end

end
