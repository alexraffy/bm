class AddColorToCollection < ActiveRecord::Migration[7.0]
  def change
    add_column :collections, :color, :string
  end
end
