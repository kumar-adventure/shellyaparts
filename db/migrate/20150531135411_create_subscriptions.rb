class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer  :plan_id
      t.string  :customer_id
      t.boolean :paid, default: false
      t.timestamps
    end
  end
end
