class DropFolderColumnInBookmark < ActiveRecord::Migration[7.0]
  def up
    remove_column :bookmarks, :folder
  end

  def down
    add_column :bookmarks, :folder, :string
  end
end
