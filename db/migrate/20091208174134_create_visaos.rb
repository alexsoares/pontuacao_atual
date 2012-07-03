class CreateVisaos < ActiveRecord::Migration
  def self.up
    create_table :visaos do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :visaos
  end
end
