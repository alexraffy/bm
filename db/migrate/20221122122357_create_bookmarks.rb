class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.text :location
      t.string :title
      t.text :description
      t.text :image_url
      t.datetime :last_visited
      t.string :folder

      t.timestamps
    end
  end
end
