class AddCamposToFichas < ActiveRecord::Migration
  def self.up
    add_column :fichas, :total_geral, :decimal, :default => 0, :precision => ('10,3')
    add_column :fichas, :total_titulacao, :decimal, :default => 0, :precision => ('10,3')
    add_column :fichas, :total_trabalhado, :decimal, :default => 0, :precision => ('10,3')
  end

  def self.down
    remove_column :fichas, :total_trabalhado
    remove_column :fichas, :total_titulacao
    remove_column :fichas, :total_geral
  end
end
