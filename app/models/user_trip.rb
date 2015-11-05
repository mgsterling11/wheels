class UserTrip < ActiveRecord::Base
  belongs_to :user
  belongs_to :origin
  belongs_to :destination

  accepts_nested_attributes_for :origin
  accepts_nested_attributes_for :destination

  

end
