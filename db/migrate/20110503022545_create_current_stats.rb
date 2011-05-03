class CreateCurrentStats < ActiveRecord::Migration
  def self.up
    create_table :current_stats do |t|
      t.integer :metric_id
      t.integer :device_id
      t.string :string_value
      t.column :value, :bigint

      t.timestamps
    end
  end

  def self.down
    drop_table :current_stats
  end
end
