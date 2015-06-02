class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|
      t.string :name
      t.float  :price
      t.string :currency
      t.timestamps
    end
  end
end
