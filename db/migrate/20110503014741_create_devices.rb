class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.string :name
      t.string :ip
      t.string :url
      t.integer :device_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :devices
  end
end
