class CreateTitulacaos < ActiveRecord::Migration
  def self.up
    create_table :titulacaos do |t|

      t.string :tipo, :null => false
      t.string :descricao, :null => false
      t.string :referencia, :null => false
      t.decimal :valor, :default => 0, :precision => ('10,3')
      t.timestamps
    end
  
    #Titulos Permanetes

    Titulacao.create :tipo => "PERMANENTE", :descricao => "SUPERIOR" , :referencia => "CURSO" , :valor => 1
    Titulacao.create :tipo => "PERMANENTE", :descricao => "CURSO DE POS-GRADUACAO LATO SENSU" , :referencia => "CURSO" , :valor => 2
    Titulacao.create :tipo => "PERMANENTE", :descricao => "MESTRADO" , :referencia => "TITULO" , :valor => 3
    Titulacao.create :tipo => "PERMANENTE", :descricao => "DOUTORADO" , :referencia => "TITULO" , :valor => 4
    Titulacao.create :tipo => "PERMANENTE", :descricao => "CURSO DE ESPECIALIZACAO / APERFEICOAMENTO (180H)" , :referencia => "CURSO" , :valor => 1

    #Titulos Anual

    Titulacao.create :tipo => "ANUAL", :descricao => "CURSOS OFER. / ACOMP. PELA SE - FORA DO TRABALHO" , :referencia => "HORAS" , :valor => '0.002'
    Titulacao.create :tipo => "ANUAL", :descricao => "OUTROS CURSOS / SIMPOSIOS /ETC." , :referencia => "HORAS" , :valor => '0.001'
    Titulacao.create :tipo => "ANUAL", :descricao => "APRESENTACAO DE COMUNICACOES" , :referencia => "COMUNICACOES" , :valor => '0.024'
  end

  def self.down
    drop_table :titulacaos
  end
end
