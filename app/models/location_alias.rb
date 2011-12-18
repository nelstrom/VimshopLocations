class LocationAlias < ActiveRecord::Base
  belongs_to :location

  validates_presence_of :city, :country, :location_id
  validates_uniqueness_of :city, scope: :country

  before_validation :downcase_fields!

  private
  def downcase_fields!
    self.city.downcase!
    self.country.downcase!
  end
end
