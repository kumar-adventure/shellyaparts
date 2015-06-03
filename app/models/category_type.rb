class CategoryType < ActiveRecord::Base

  validates_presence_of :name
  has_many :categories

  scope :published, -> { where(published: true) }
end
