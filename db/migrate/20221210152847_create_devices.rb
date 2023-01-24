class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :device_guid
      t.text :info
      t.boolean :enabled
      t.boolean :need_confirmation

      t.timestamps
    end
  end
end
