class AddEntradaConcursoToProfessors < ActiveRecord::Migration
  def self.up
    add_column :professors, :entrada_concurso, :string
  end

  def self.down
    remove_column :professors, :entrada_concurso
  end
end
