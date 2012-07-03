class CreateTituloProfessors < ActiveRecord::Migration
  def self.up
    create_table :titulo_professors do |t|
      t.references :titulo, :null => false
      t.references :professor, :null => false
      t.string :obs, :null => false
      t.integer :quantidade, :default => 0
      t.decimal :pontuacao_titulo, :precision => ('10,3'), :default => 0
      t.decimal :valor, :precision => ('10,3'), :default => 0
      t.date :dt_titulo
      t.date :dt_validade
      t.boolean :status, :default => true
      t.integer :validade, :default => 0
      t.integer :ano_letivo, :default =>0
      t.timestamps
    end
  end

  def self.down
    drop_table :titulo_professors
  end
end
