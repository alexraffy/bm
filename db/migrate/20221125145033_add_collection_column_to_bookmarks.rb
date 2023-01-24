class AddCollectionColumnToBookmarks < ActiveRecord::Migration[7.0]
  def change
    add_column :bookmarks, :collection, :integer, default: 0
  end
end
