class CreateFichas < ActiveRecord::Migration
  def self.up
    create_table :fichas do |t|
      t.references :professor
      t.references :acum_trab
      t.references :trabalhado_anterior
      t.references :trabalhado_atual

      t.timestamps
    end
  end

  def self.down
    drop_table :fichas
  end
end
