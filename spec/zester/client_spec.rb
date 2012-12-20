require 'spec_helper'

describe Zester::Client do
  context "basic" do
    let!(:zester) {new_zester}

    it "should set the zws_id" do
      zester.zws_id.should == ZWS_ID
      zester.http_timeout.should be_nil
      zester.class.default_params.should == {'zws-id' => ZWS_ID}
    end

    it "should set the base uri for the client" do
      zester.class.base_uri.should == "http://www.zillow.com/webservice"
    end

    it "should return an instance of Zester::Valuation for valuation" do
      zester.valuation.should be_kind_of(Zester::Valuation)
      zester.valuation.client.should == zester
    end

    it "should return an instance of Zester::Valuatiion for property" do
      zester.property.should be_kind_of(Zester::Property)
      zester.property.client.should == zester
    end

    it "should return an instance of Zester::Valuatiion for mortgage" do
      zester.mortgage.should be_kind_of(Zester::Mortgage)
      zester.mortgage.client.should == zester
    end

    it "should return an instance of Zester::Valuatiion for neighborhood" do
      zester.neighborhood.should be_kind_of(Zester::Neighborhood)
      zester.neighborhood.client.should == zester
    end
  end

  context "timeout" do
    let!(:zester) {new_timeout_zester}

    it "should set the zws_id" do
      zester.zws_id.should == ZWS_ID
      zester.http_timeout.should == 5
      zester.class.default_params.should == {'zws-id' => ZWS_ID}
    end
  end
end
