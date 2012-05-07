require 'spec_helper'

describe Zester::Neighborhood do
  let!(:zester) {new_zester}
  let!(:neighborhood) {zester.neighborhood}

  context "demographics" do
    it "should check for required params" do
      VCR.use_cassette('neighborhood') do
        expect {neighborhood.demographics}.to raise_error(ArgumentError, "At least rid or state & city or city & neighborhood or zip is required")
        expect {neighborhood.demographics('regionid' => 'MA')}.to_not raise_error(ArgumentError)
        expect {neighborhood.demographics('state' => 'MA')}.to raise_error(ArgumentError, "At least rid or state & city or city & neighborhood or zip is required")
        expect {neighborhood.demographics('city' => 'Boston')}.to raise_error(ArgumentError, "At least rid or state & city or city & neighborhood or zip is required")
        expect {neighborhood.demographics('neighborhood' => 'Back Bay')}.to raise_error(ArgumentError, "At least rid or state & city or city & neighborhood or zip is required")
        expect {neighborhood.demographics('zip' => '02118')}.to_not raise_error(ArgumentError)
        expect {neighborhood.demographics('state' => 'MA', 'city' => 'Boston')}.to_not raise_error(ArgumentError)
        expect {neighborhood.demographics('city' => 'Boston', 'neighborhood' => 'Back Bay')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('neighborhood') do
        response = neighborhood.demographics('state' => 'MA', 'city' => 'Boston')
        response.success?.should be_true
        response.region.should_not be_nil
        response.pages.should_not be_nil
        response.market.should_not be_nil
        response.links.should_not be_nil
        response.charts.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('neighborhood') do
        response = neighborhood.demographics('regionid' => 'MA')
        response.success?.should be_false
        response.response_code.should ==  500
        response.error_message.should_not be_nil
        response.should_not respond_to(:region)
        response.should_not respond_to(:pages)
        response.should_not respond_to(:market)
        response.should_not respond_to(:links)
        response.should_not respond_to(:charts)
      end
    end
  end

  context "region_children" do
    it "should check for required params" do
      VCR.use_cassette('neighborhood') do
        expect {neighborhood.region_children}.to raise_error(ArgumentError, "At least region_id or state is required")
        expect {neighborhood.region_children('state' => 'MA')}.to_not raise_error(ArgumentError)
        expect {neighborhood.region_children('regionId' => 'MA')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('neighborhood') do
        response = neighborhood.region_children('state' => 'MA')
        response.success?.should be_true
        response.region.should_not be_nil
        response.subregiontype.should_not be_nil
        response.list.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('neighborhood') do
        response = neighborhood.region_children('state' => 'YZ')
        response.success?.should be_false
        response.response_code.should ==  502
        response.error_message.should_not be_nil
        response.should_not respond_to(:region)
        response.should_not respond_to(:subregiontype)
        response.should_not respond_to(:list)
      end
    end
  end

  context "region_chart" do
    it "should check for required params" do
      VCR.use_cassette('neighborhood') do
        expect {neighborhood.region_chart}.to raise_error(ArgumentError, "unit-type is required")
        expect {neighborhood.region_chart('unit-type' => 'dollar')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('neighborhood') do
        response = neighborhood.region_chart('unit-type' => 'dollar')
        response.success?.should be_true
        response.zindex.should_not be_nil
        response.url.should_not be_nil
        response.links.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('neighborhood') do
        response = neighborhood.region_chart('unit-type' => 'none')
        response.success?.should_not be_true
        response.response_code.should ==  502
        response.error_message.should_not be_nil
        response.should_not respond_to(:zindex)
        response.should_not respond_to(:url)
        response.should_not respond_to(:links)
      end
    end
  end

end
