class AddTypeOfToRemocaos < ActiveRecord::Migration
  def self.up
    add_column :remocaos, :type_of, :integer
  end

  def self.down
    remove_column :remocaos, :type_of
  end
end
