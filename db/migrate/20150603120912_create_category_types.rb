class CreateCategoryTypes < ActiveRecord::Migration
  def change
    create_table :category_types do |t|
      t.string :name
      t.boolean :published, default: false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :category_types, :deleted_at
  end
end
