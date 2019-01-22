module Zester
  class Property < Resource

    def deep_comps(params = {})
      if params['zpid'].nil?
        raise ArgumentError, "zpid is required"
      end
      params['count'] ||= 10
      get_results('GetDeepComps', :comps, params)
    end

    def deep_search_results(params = {})
      if params['address'].nil? || params['citystatezip'].nil?
        raise ArgumentError, "address and citystatezip are required"
      end
      get_results('GetDeepSearchResults', :searchresults, params)
    end

    def search_results(params = {})
      if params['address'].nil? || params['citystatezip'].nil?
        raise ArgumentError, "address and citystatezip are required"
      end
      get_results('GetSearchResults', :searchresults, params)
    end

    def updated_property_details(params = {})
      if params['zpid'].nil?
        raise ArgumentError, "zpid is required"
      end
      get_results('GetUpdatedPropertyDetails', :updated_property_details, params)
    end

  end
end
