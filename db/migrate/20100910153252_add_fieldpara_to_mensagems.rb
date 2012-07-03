class AddFieldparaToMensagems < ActiveRecord::Migration
  def self.up
    add_column :mensagems, :para, :integer
  end

  def self.down
    remove_column :mensagems, :para
  end
end
