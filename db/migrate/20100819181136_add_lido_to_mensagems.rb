class AddLidoToMensagems < ActiveRecord::Migration
  def self.up
    add_column :mensagems, :lido, :boolean
  end

  def self.down
    remove_column :mensagems, :lido
  end
end
