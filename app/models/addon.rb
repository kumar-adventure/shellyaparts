class Addon < ActiveRecord::Base
  acts_as_paranoid
  validates_presence_of :name, :price, :currency

  has_many :subscriptions, :as => :subscriptionable
  has_many :users, through: :subscriptions

  scope :active, -> { where(activated: true) }
  scope :inactive, -> { where(activated: false) }

  before_destroy :update_activation


  private
  def update_activation
    update_attributes(activated: false)
  end
end
