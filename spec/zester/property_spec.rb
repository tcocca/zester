require 'spec_helper'

describe Zester::Property do
  let!(:zester) {new_zester}
  let!(:property) {zester.property}

  context "deep_comps" do
    it "should check for required params" do
      VCR.use_cassette('property') do
        expect {property.deep_comps}.to raise_error(ArgumentError, "zpid is required")
        expect {property.deep_comps('zpid' => '12345')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('property') do
        response = property.deep_comps('zpid' => '48749425')
        response.success?.should be_true
        response.properties.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('property') do
        response = property.deep_comps('zpid' => 'xyz')
        response.success?.should be_false
        response.response_code.should ==  500
        response.error_message.should_not be_nil
        response.should_not respond_to(:properties)
      end
    end
  end

  context "deep_search_results" do
    it "should check for required params" do
      VCR.use_cassette('property') do
        expect {property.deep_search_results}.to raise_error(ArgumentError, "address and citystatezip are required")
        expect {property.deep_search_results('address' => '2114 Bigelow Ave', 'citystatezip' => 'Seattle, WA')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('property') do
        response = property.deep_search_results('address' => '2114 Bigelow Ave', 'citystatezip' => 'Seattle, WA')
        response.success?.should be_true
        response.results.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('property') do
        response = property.deep_search_results('address' => '2114 Bigelow Ave', 'citystatezip' => '123')
        response.success?.should be_false
        response.response_code.should ==  508
        response.error_message.should_not be_nil
        response.should_not respond_to(:results)
      end
    end
  end

  context "updated_property_details" do
    it "should check for required params" do
      VCR.use_cassette('property') do
        expect {property.updated_property_details}.to raise_error(ArgumentError, "zpid is required")
        expect {property.updated_property_details('zpid' => '12345')}.to_not raise_error(ArgumentError)
      end
    end

    it "should return a success" do
      VCR.use_cassette('property') do
        response = property.updated_property_details('zpid' => '1')
        response.success?.should be_true
        response.zpid.should_not be_nil
      end
    end

    it "should return a failure" do
      VCR.use_cassette('property') do
        response = property.updated_property_details('zpid' => 'xyz')
        response.success?.should be_false
        response.response_code.should ==  500
        response.error_message.should_not be_nil
        response.should_not respond_to(:address)
        response.should_not respond_to(:links)
        response.should_not respond_to(:edited_facts)
        response.should_not respond_to(:neighborhood)
        response.should_not respond_to(:school_district)
        response.should_not respond_to(:elementary_school)
        response.should_not respond_to(:middle_school)
      end
    end
  end

end
