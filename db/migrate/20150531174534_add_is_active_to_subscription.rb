class AddIsActiveToSubscription < ActiveRecord::Migration
  
  def up
  	add_column :subscriptions, :is_active, :boolean, default: false
  end

  def down
  	remove_column :subscriptions, :is_active
  end

end
