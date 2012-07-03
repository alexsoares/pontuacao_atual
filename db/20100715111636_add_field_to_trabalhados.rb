class AddFieldToTrabalhados < ActiveRecord::Migration
  def self.up
    add_column :trabalhados, :call_back, :boolean
  end

  def self.down
    remove_column :trabalhados, :call_back
  end
end
