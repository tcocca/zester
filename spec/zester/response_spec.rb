require 'spec_helper'

describe Zester::Response do
  let!(:zester) {new_zester}
  let!(:resource) {Zester::Resource.new(zester)}

  it "should return a success" do
    VCR.use_cassette('response') do
      response = get_response
      response.success?.should be_true
      response.message.should_not be_nil
      response.message.code.should == "0"
      response.response_code.should == 0
      response.should be_instance_of(Zester::Response)
      response.body.should be_instance_of(Hashie::Rash)
    end
  end

  it "should return a failure" do
    VCR.use_cassette('response') do
      response = get_response('XZ')
      response.success?.should be_false
      response.error_message.should_not be_nil
      response.message.code.should == "502"
      response.response_code.should == 502
    end
  end

  context "respond_to?" do
    it "should respond to methods called from body.response" do
      VCR.use_cassette('response') do
        response = get_response
        response.should respond_to(:region)
        response.should respond_to(:subregiontype)
      end
    end

    it "should not respond to methods called off body.response" do
      VCR.use_cassette('response') do
        response = get_response('XZ')
        response.should_not respond_to(:region)
        response.should_not respond_to(:subregiontype)
      end
    end
  end

  context "method_missing" do
    it "should call methods off of the body.response" do
      VCR.use_cassette('response') do
        response = get_response
        response.subregiontype.should == response.body.response.subregiontype
      end
    end

    it "should raise errors when the method does not exist" do
      VCR.use_cassette('response') do
        response = get_response('XZ')
        expect {response.region}.to raise_error(NoMethodError)
        expect {response.subregiontype}.to raise_error(NoMethodError)
      end
    end
  end

end
