class CreateImportBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :import_bookmarks do |t|
      t.text :location
      t.boolean :processed
      t.boolean :queued

      t.timestamps
    end
  end
end
