class Location < ActiveRecord::Base

  has_many :subscribers
  validates_presence_of :city, :country
  validates_uniqueness_of :city, scope: :country

  scope :ranked, :order => "subscribers_count DESC,city ASC,country ASC"

  def self.find_or_create_normalised_location(city, country)
    if res = geocode("#{city}, #{country}")
      city = res.city || city # Sometimes we have a blank city
      # Search for this place again
      if loc = Location.find_by_city_and_country(city, res.country)
        loc
      else
        Location.create({
          city:       city,
          country:    res.country,
          state:      res.state,
          latitude:   res.latitude,
          longitude:  res.longitude
        })
      end
    end
  end

  def self.geocode(address)
    tries = 0
    begin
      tries += 1
      sleep(0.5)
      Rails.logger.info "Geocoding #{address}"
      geo = Graticule.service(:google).new '' # Blank API key
      geo.locate address
    rescue
      puts "Failed to locate #{address}"
      if tries < 2
        address.sub!(/, Republic of/i, '')
        puts "Attempting with: #{address}"
        retry
      end
    end
  end

  def self.country_count
    select("DISTINCT(country)").count
  end
end
