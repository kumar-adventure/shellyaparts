class Category < ActiveRecord::Base
  acts_as_paranoid

  validates_presence_of :name, :category_alias, :category_type_id
  belongs_to :category_type

  mount_uploader :avatar, AvatarUploader

  scope :published, -> { where(published: true) }

end
