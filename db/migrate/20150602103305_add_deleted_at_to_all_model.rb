class AddDeletedAtToAllModel < ActiveRecord::Migration
  def up
    add_column :admins, :deleted_at, :datetime
    add_index :admins, :deleted_at
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at
    add_column :plans, :deleted_at, :datetime
    add_index :plans, :deleted_at
    add_column :addons, :deleted_at, :datetime
    add_index :addons, :deleted_at
    add_column :subscriptions, :deleted_at, :datetime
    add_index :subscriptions, :deleted_at                
  end
end
