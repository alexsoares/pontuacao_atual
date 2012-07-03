class AddAnoLetivoToFichas < ActiveRecord::Migration
  def self.up
    add_column :fichas, :ano_letivo, :integer
  end

  def self.down
    remove_column :fichas, :ano_letivo
  end
end
