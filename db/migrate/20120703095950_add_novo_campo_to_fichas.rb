class AddNovoCampoToFichas < ActiveRecord::Migration
  def self.up
    add_column :fichas, :entrada_concurso, :string
  end

  def self.down
    remove_column :fichas, :entrada_concurso
  end
end
