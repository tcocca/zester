ZWS_ID = YAML.load_file(File.join(File.dirname(__FILE__), '/../zillow_api_key.yml'))["zws_id"]

def new_zester
  Zester::Client.new(ZWS_ID)
end

def new_timeout_zester
  Zester::Client.new(ZWS_ID, 5)
end

def get_response(state = 'CA')
  resource.get_results('GetRegionChildren', :regionchildren, state: state)
end
