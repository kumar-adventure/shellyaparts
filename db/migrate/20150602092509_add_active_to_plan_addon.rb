class AddActiveToPlanAddon < ActiveRecord::Migration
  def up
    add_column :plans, :activated, :boolean, default: false
    add_column :addons, :activated, :boolean, default: false
  end

  def down
    remove_column :plans, :activated
    remove_column :addons, :activated
  end
end
