class AddTipoCursoToTituloProfessors < ActiveRecord::Migration
  def self.up
    add_column :titulo_professors, :tipo_curso, :boolean
  end

  def self.down
    remove_column :titulo_professors, :tipo_curso
  end
end
