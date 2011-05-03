class CreatePollgroups < ActiveRecord::Migration
  def self.up
    create_table :pollgroups do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :pollgroups
  end
end
