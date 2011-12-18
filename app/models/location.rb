class Location < ActiveRecord::Base

  has_many :subscribers
  has_many :location_aliases

  validates_presence_of :city, :country
  validates_uniqueness_of :city, scope: :country

  # Search for a location alias with city and country equal to arguments
  # If an alias is found, return its location
  # Otherwise, create a location and an alias for the location
  def self.find_or_create_normalised_location(city, country)
    if res = geocode("#{city}, #{country}")
      # Seems sometimes city is nil
      city = res.city unless res.city.blank?
      # Search for this place again
      if als = LocationAlias.find_by_city_and_country(city.downcase, res.country.downcase)
        als.location
      else
        loc = Location.create!({
          city:       city,
          country:    res.country,
          state:      res.state,
          latitude:   res.latitude,
          longitude:  res.longitude
        })
        loc.location_aliases.create city: city, country: res.country
        loc
      end
    end
  end

  def self.geocode(address)
    sleep(0.5)
    Rails.logger.info "Geocoding #{address}"
    geo = Graticule.service(:google).new '' # Blank API key
    geo.locate address
  end
end
