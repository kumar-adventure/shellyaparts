class Plan < ActiveRecord::Base

  validates_presence_of :name, :price, :currency

  has_many :subscriptions
  has_many :users, through: :subscriptions
  
end
