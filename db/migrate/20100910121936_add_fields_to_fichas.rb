class AddFieldsToFichas < ActiveRecord::Migration
  def self.up
    add_column :fichas, :tot_acum_ant_trab, :decimal, :default => 0, :precision => ('10,0')
    add_column :fichas, :tot_acum_ant_efet, :decimal, :default => 0, :precision => ('10,0')
    add_column :fichas, :tot_acum_ant_rede, :decimal, :default => 0, :precision => ('10,0')
    add_column :fichas, :tot_acum_ant_unid, :decimal, :default => 0, :precision => ('10,0')
    add_column :fichas, :tot_acum_trab, :decimal, :precision => ('10,0')
    add_column :fichas, :tot_acum_efet, :decimal, :precision => ('10,0')
    add_column :fichas, :tot_acum_rede, :decimal, :precision => ('10,0')
    add_column :fichas, :tot_acum_unid, :decimal, :precision => ('10,0')
    add_column :fichas, :valor_trab, :decimal, :precision => ('10,3')
    add_column :fichas, :valor_efet, :decimal, :precision => ('10,3')
    add_column :fichas, :valor_rede, :decimal, :precision => ('10,3')
    add_column :fichas, :valor_unid, :decimal, :precision => ('10,3')
    add_column :fichas, :tot_geral_trab, :decimal, :precision => ('10,3')
    add_column :fichas, :tot_geral_efet, :decimal, :precision => ('10,3')
    add_column :fichas, :tot_geral_rede, :decimal, :precision => ('10,3')
    add_column :fichas, :tot_geral_unid, :decimal, :precision => ('10,3')
  end

  def self.down
    remove_column :fichas, :tot_geral_unid
    remove_column :fichas, :tot_geral_rede
    remove_column :fichas, :tot_geral_efet
    remove_column :fichas, :tot_geral_trab
    remove_column :fichas, :valor_unid
    remove_column :fichas, :valor_rede
    remove_column :fichas, :valor_efet
    remove_column :fichas, :valor_trab
    remove_column :fichas, :tot_acum_unid
    remove_column :fichas, :tot_acum_trab
    remove_column :fichas, :tot_acum_ant_unid
    remove_column :fichas, :tot_acum_ant_rede
    remove_column :fichas, :tot_acum_ant_efet
    remove_column :fichas, :tot_acum_ant_trab
  end
end
