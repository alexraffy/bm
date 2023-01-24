class AddTotalToImportbookmarks < ActiveRecord::Migration[7.0]
  def change
    add_column :import_bookmarks, :total, :integer
  end
end
