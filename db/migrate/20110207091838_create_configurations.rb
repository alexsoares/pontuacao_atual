class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.references :user
      t.date :data

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
