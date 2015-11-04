class Destination < ActiveRecord::Base
  geocoded_by :address
  before_save :geocode, :if => :address_changed?
  has_many :user_trips
end