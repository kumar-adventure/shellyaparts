class VehicleModel < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of :name, :vehicle_make_id
  validates_uniqueness_of :name

  has_many :vehicles
  belongs_to :vehicle_make

  scope :published, -> { where(published: true) }
 
end
