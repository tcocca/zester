module Zester
  class Valuation < Resource

    def zestimate(params = {})
      if params['zpid'].nil?
        raise ArgumentError, "zpid is required"
      end
      get_results('GetZestimate', :zestimate, params)
    end

    def search_results(params = {})
      if params['address'].nil? || params['citystatezip'].nil?
        raise ArgumentError, "address and citystatezip are required"
      end
      get_results('GetSearchResults', :searchresults, params)
    end

    def chart(params = {})
      if params['zpid'].nil?
        raise ArgumentError, "zpid is required"
      end
      params['unit-type'] ||= 'dollar'
      get_results('GetChart', :chart, params)
    end

    def comps(params = {})
      if params['zpid'].nil?
        raise ArgumentError, "zpid is required"
      end
      params['count'] ||= 10
      get_results('GetComps', :comps, params)
    end

  end
end
