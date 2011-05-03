class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :device_type_id
      t.integer :pollgroup_id

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
