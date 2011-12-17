class Location < ActiveRecord::Base
  has_many :subscribers
  has_many :location_aliases
end
