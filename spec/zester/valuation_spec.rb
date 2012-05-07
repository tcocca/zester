require 'spec_helper'

describe Zester::Valuation do
  let!(:zester) {new_zester}
  let!(:valuation) {zester.valuation}

  context "zestimate" do
    it "should check for required params" do
      VCR.use_cassette('valuation') do
        expect {valuation.zestimate}.to raise_error(ArgumentError, "zpid is required")
        expect {valuation.zestimate('zpid' => '12345')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('valuation') do
        response = valuation.zestimate('zpid' => '48749425')
        response.success?.should be_true
        response.zpid.should_not be_nil
        response.links.should_not be_nil
        response.address.should_not be_nil
        response.zestimate.should_not be_nil
        response.local_real_estate.should_not be_nil
        response.regions.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('valuation') do
        response = valuation.zestimate('zpid' => 'xyz')
        response.success?.should be_false
        response.response_code.should ==  500
        response.error_message.should_not be_nil
        response.should_not respond_to(:zpid)
        response.should_not respond_to(:links)
        response.should_not respond_to(:address)
        response.should_not respond_to(:zestimate)
        response.should_not respond_to(:local_real_estate)
        response.should_not respond_to(:regions)
      end
    end
  end

  context "search_results" do
    it "should check for required params" do
      VCR.use_cassette('valuation') do
        expect {valuation.search_results}.to raise_error(ArgumentError, "address and citystatezip are required")
        expect {valuation.search_results('address' => '2114 Bigelow Ave', 'citystatezip' => 'Seattle, WA')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('valuation') do
        response = valuation.search_results('address' => '2114 Bigelow Ave', 'citystatezip' => 'Seattle, WA')
        response.success?.should be_true
        response.results.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('valuation') do
        response = valuation.search_results('address' => '2114 Bigelow Ave', 'citystatezip' => '123')
        response.success?.should be_false
        response.response_code.should ==  508
        response.error_message.should_not be_nil
        response.should_not respond_to(:results)
      end
    end
  end

  context "chart" do
    it "should check for required params" do
      VCR.use_cassette('valuation') do
        expect {valuation.chart}.to raise_error(ArgumentError, "zpid is required")
        expect {valuation.chart('zpid' => '12345')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('valuation') do
        response = valuation.chart('zpid' => '48749425')
        response.success?.should be_true
        response.url.should_not be_nil
        response.graphsanddata.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('valuation') do
        response = valuation.chart('zpid' => 'xyz')
        response.success?.should be_false
        response.response_code.should ==  500
        response.error_message.should_not be_nil
        response.should_not respond_to(:url)
        response.should_not respond_to(:graphsanddata)
      end
    end
  end

  context "comps" do
    it "should check for required params" do
      VCR.use_cassette('valuation') do
        expect {valuation.comps}.to raise_error(ArgumentError, "zpid is required")
        expect {valuation.comps('zpid' => '12345')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('valuation') do
        response = valuation.comps('zpid' => '48749425')
        response.success?.should be_true
        response.properties.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('valuation') do
        response = valuation.comps('zpid' => 'xyz')
        response.success?.should be_false
        response.response_code.should ==  500
        response.error_message.should_not be_nil
        response.should_not respond_to(:properties)
      end
    end
  end

end
