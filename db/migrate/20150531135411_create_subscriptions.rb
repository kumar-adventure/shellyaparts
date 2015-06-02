class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :subscriptionable_id
      t.string  :subscriptionable_type
      t.string  :customer_id
      t.boolean :is_active, default: false
      t.string  :status, default: nil
      t.timestamps
    end
  end
end
