class CreateVehicleModels < ActiveRecord::Migration
  def change
    create_table :vehicle_models do |t|
      t.references :vehicle_make, index: true
      t.string :name
      t.boolean :published, default: false
      t.timestamps
    end
  end
end
