module Zester
  class Neighborhood < Resource

    def demographics(params = {})
      if params['regionid'].nil? && 
        (params['state'].nil? || params['city'].nil?) && 
        (params['city'].nil? || params['neighborhood'].nil?) && 
        params['zip'].nil?
        raise ArgumentError, "At least rid or state & city or city & neighborhood or zip is required"
      end
      get_results('GetDemographics', :demographics, params)
    end

    def region_children(params = {})
      if params['regionId'].nil? && params['state'].nil?
        raise ArgumentError, "At least region_id or state is required"
      end
      get_results('GetRegionChildren', :regionchildren, params)
    end

    def region_chart(params = {})
      if params['unit-type'].nil?
        raise ArgumentError, "unit-type is required"
      end
      get_results('GetRegionChart', :regionchart, params)
    end

  end
end
