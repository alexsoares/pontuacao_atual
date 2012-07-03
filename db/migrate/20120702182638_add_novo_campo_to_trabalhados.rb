class AddNovoCampoToTrabalhados < ActiveRecord::Migration
  def self.up
    add_column :trabalhados, :outras_ausencias, :integer, :default => 0
  end

  def self.down
    remove_column :trabalhados, :outras_ausencias
  end
end
