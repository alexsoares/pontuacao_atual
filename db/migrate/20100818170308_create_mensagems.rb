class CreateMensagems < ActiveRecord::Migration
  def self.up
    create_table :mensagems do |t|
      t.references :user
      t.string :titulo
      t.string :from
      t.string :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :mensagems
  end
end
