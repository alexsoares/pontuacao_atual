class AddFieldGeralToMensagems < ActiveRecord::Migration
  def self.up
    add_column :mensagems, :geral, :integer, :default => 0
  end

  def self.down
    remove_column :mensagems, :geral
  end
end
