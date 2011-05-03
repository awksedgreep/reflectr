class CreateMetrics < ActiveRecord::Migration
  def self.up
    create_table :metrics do |t|
      t.string :name
      t.integer :pollgroup_id
      t.integer :metric_type_id
      t.integer :data_type_id
      t.integer :port
      t.string :property

      t.timestamps
    end
  end

  def self.down
    drop_table :metrics
  end
end
