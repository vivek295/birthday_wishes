class Wish < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :wish
  self.skip_time_zone_conversion_for_attributes = [:date]
end
