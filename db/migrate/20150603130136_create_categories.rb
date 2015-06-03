class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :category_alias
      t.references :category_type
      t.boolean :published, default: false
      t.string :avatar
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :categories, :deleted_at
  end
end
