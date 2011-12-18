class RankingsController < ApplicationController

  def index
    @ranked = Location.ranked  
    @subscribers_count = Subscriber.count
    @location_count = Location.count
    @country_count = Location.country_count
  end

end
