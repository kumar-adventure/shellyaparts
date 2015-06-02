class Subscription < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :user
  belongs_to :subscriptionable, :polymorphic => true

  scope :active, -> { where(is_active: true) }
  scope :inactive, -> { where(is_active: false) }
  scope :active_plan, -> { where(is_active: true, subscriptionable_type: "Plan") }
  scope :active_addon, -> { where(is_active: true, subscriptionable_type: "Addon") }
  paginates_per 10

end
