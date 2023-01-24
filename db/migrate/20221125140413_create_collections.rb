class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.string :title
      t.integer :parent_collection
      t.string :icon

      t.timestamps
    end
  end
end
