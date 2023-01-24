class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.integer :device
      t.string :token
      t.datetime :limit

      t.timestamps
    end
  end
end
