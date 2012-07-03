class CreateRegiaos < ActiveRecord::Migration
  def self.up
    create_table :regiaos do |t|
      t.string :nome, :limit => 30

      t.timestamps
    end
    Regiao.create :nome => "SAO JERONIMO"
    Regiao.create :nome => "CIDADE JARDIM"
    Regiao.create :nome => "SAO VITO"
    Regiao.create :nome => "ZANAGA"
    Regiao.create :nome => "JARDIM IPIRANGA"
    Regiao.create :nome => "CENTRO"
    Regiao.create :nome => "JARDIM BRASIL"
    Regiao.create :nome => "PRAIA AZUL"
    Regiao.create :nome => "JARDIM DA PAZ "
    Regiao.create :nome => "JARDIM DOS LIRIOS"
    Regiao.create :nome => "PARQUE DAS NACOES"
    Regiao.create :nome => "SAO ROQUE"
    Regiao.create :nome => "PARQUE GRAMADO"
    Regiao.create :nome => "JARDIM PROGRESSO"
    Regiao.create :nome => "PROFILURBE"
    Regiao.create :nome => "JARDIM LILASES"
    Regiao.create :nome => "PARQUE DA LIBERDADE "
    Regiao.create :nome => "MATHIENSEN"
    Regiao.create :nome => "CORDENUCI"
    Regiao.create :nome => "JARDIM SAO PEDRO"
    Regiao.create :nome => "JARDIM SAO MANOEL"
    Regiao.create :nome => "NAO ALOCADO"

  end

  def self.down
    drop_table :regiaos
  end
end

