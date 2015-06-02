class VehicleMake < ActiveRecord::Base
  acts_as_paranoid
  has_many :vehicles
  has_many :vehicle_models, dependent: :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name
  scope :published, -> { where(published: true) }

end
