class AddDeletedAtToMakeAndModel < ActiveRecord::Migration
  def up
    add_column :vehicle_makes, :deleted_at, :datetime
    add_index :vehicle_makes, :deleted_at
    add_column :vehicle_models, :deleted_at, :datetime
    add_index :vehicle_models, :deleted_at
  end
end
