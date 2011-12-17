class LocationAlias < ActiveRecord::Base
  belongs_to :location

  before_save :downcase_fields!

  private
  def downcase_fields!
    self.city.downcase!
    self.country.downcase!
  end
end
