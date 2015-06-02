class VehicleModel < ActiveRecord::Base
  acts_as_paranoid
  has_many :vehicles
  belongs_to :vehicle_make

  scope :published, -> { where(published: true) }
 
end
