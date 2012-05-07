module Zester
  class Mortgage < Resource

    def rate_summary(state = nil)
      get_results('GetRateSummary', :rate_summary, {'state' => state})
    end

  end
end
