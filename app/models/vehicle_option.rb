class VehicleOption < ActiveRecord::Base
  acts_as_paranoid

  validates :name, presence: true	

  scope :published, -> { where(published: true) }
  
end
