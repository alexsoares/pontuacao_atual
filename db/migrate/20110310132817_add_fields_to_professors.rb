class AddFieldsToProfessors < ActiveRecord::Migration
  def self.up
    add_column :professors, :titulo_arrumado, :boolean
  end

  def self.down
    remove_column :professors, :titulo_arrumado
  end
end
