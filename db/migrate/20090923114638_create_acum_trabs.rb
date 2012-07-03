class CreateAcumTrabs < ActiveRecord::Migration
  def self.up
    create_table :acum_trabs do |t|
      t.references :professor

      t.decimal :tot_acum_ant_trab, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_ant_efet, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_ant_rede, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_ant_unid, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_trab, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_efet, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_rede, :default => 0, :precision => ('10,0')
      t.decimal :tot_acum_unid, :default => 0, :precision => ('10,0')
      t.decimal :tot_geral_trab, :default => 0, :precision => ('10,3')
      t.decimal :tot_geral_efet, :default => 0, :precision => ('10,3')
      t.decimal :tot_geral_rede, :default => 0, :precision => ('10,3')
      t.decimal :tot_geral_unid, :default => 0, :precision => ('10,3')
      t.decimal :pont_base_trab, :default => 0, :precision => ('10,3')
      t.decimal :pont_base_efet, :default => 0, :precision => ('10,3')
      t.decimal :pont_base_rede, :default => 0, :precision => ('10,3')
      t.decimal :pont_base_unid, :default => 0, :precision => ('10,3')
      t.decimal :valor_trab, :default => 0, :precision => ('10,3')
      t.decimal :valor_efet, :default => 0, :precision => ('10,3')
      t.decimal :valor_rede, :default => 0, :precision => ('10,3')
      t.decimal :valor_unid, :default => 0, :precision => ('10,3')
      t.integer :status, :default => 0
      t.integer :verifica, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :acum_trabs
  end
end
