class CreateTrabalhados < ActiveRecord::Migration
  def self.up
    
    create_table :trabalhados do |t|
    t.references :professor, :null => false
    t.integer :ano, :null => false
    t.integer :dias, :default => 0
    t.integer :unidade,:default => 0
    t.integer :outro_trab,  :default => 0
    t.integer :f_abonada, :default => 0
    t.integer :atestado,:default => 0
    t.integer :f_justif,:default => 0
    t.integer :f_injustif,:default => 0
    t.integer :lic_saude,:default => 0
    t.integer :afastamento,:default => 0
    t.integer :dias_trab,:default => 0
    t.integer :dias_efetivos,:default => 0
    t.integer :dias_rede,:default => 0
    t.integer :dias_unidade,:default => 0
    t.boolean :flag, :default => 0
    t.integer :ano_letivo, :defautl =>0
    t.boolean :remocao

    t.timestamps
    end
  end

  def self.down
    drop_table :trabalhados
  end
end
