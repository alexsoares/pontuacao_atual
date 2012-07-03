class CreateCorrecaos < ActiveRecord::Migration
  def self.up
    create_table :correcaos do |t|
      t.references :professor
      t.references :acum_trab
      t.decimal :valor_ant
      t.decimal :valor

      t.timestamps
    end
  end

  def self.down
    drop_table :correcaos
  end
end
