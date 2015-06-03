class CategoryType < ActiveRecord::Base
  acts_as_paranoid
  
  validates_presence_of :name
  has_many :categories, dependent: :destroy

  scope :published, -> { where(published: true) }
end
