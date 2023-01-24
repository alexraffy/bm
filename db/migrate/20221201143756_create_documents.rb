class CreateDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :documents do |t|
      t.string :doc_type
      t.string :title
      t.text :description
      t.text :location
      t.integer :collection
      t.datetime :last_visited
      t.text :content
      t.text :image_url
      t.text :tags

      t.timestamps
    end
  end
end
