class CreateRemocaos < ActiveRecord::Migration
  def self.up
    create_table :remocaos do |t|
      t.references :professor
      t.integer :ano_letivo
      t.boolean :remocao
      t.decimal :valor_unid, :precision => ('10,3')
      t.integer :unidade_ant, :default => 0, :null => false
      t.integer :unidade_atual, :default => 0, :null => false
      t.integer :status, :default => 0, :null => false
      t.references :unidade
      t.boolean :remocao_efetivada
      t.decimal :tot_acum_unid, :precision => ('10,3')
      t.decimal :tot_geral_unid, :precision => ('10,3')
      t.decimal :total, :precision => ('10,3')
      t.integer :flag_remocao_finalizada
      t.timestamps
    end
  end

  def self.down
    drop_table :remocaos
  end
end
