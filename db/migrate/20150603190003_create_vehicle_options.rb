class CreateVehicleOptions < ActiveRecord::Migration
  def change
    create_table :vehicle_options do |t|
      t.string :name
      t.datetime :deleted_at
      t.boolean :published, default: false
      t.timestamps
    end
    add_index :vehicle_options, :deleted_at
  end
end
