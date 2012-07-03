class CreateUnidades < ActiveRecord::Migration
  def self.up
    create_table :unidades do |t|

      t.string :nome
      t.integer :tipo
      t.references :regiao
      t.timestamps
    end
# Tipos:
    # 1 - CRECHE
    # 2 - EMEI
    # 3 - CASA DA CRIANÇA
    # 4 - EMEF
    # 5 - CIEP
    # 6 - TEMPO DE VIVER

    # São Jerônimo
    
    Unidade.create :nome => "TEMPO DE VIVER", :tipo => 6 , :regiao_id => 1
    Unidade.create :nome => "ARAPIRANGA", :tipo => 3 , :regiao_id => 1
    Unidade.create :nome => "BITU", :tipo => 3, :regiao_id => 1
    Unidade.create :nome => "MAIRA", :tipo => 3, :regiao_id  => 1
    Unidade.create :nome => "JURITI", :tipo => 3, :regiao_id => 1
    Unidade.create :nome => "JACY", :tipo => 2, :regiao_id => 1
    Unidade.create :nome => "ARACY", :tipo => 2, :regiao_id => 1
    Unidade.create :nome => "CAIC", :tipo => 1, :regiao_id => 1
# Cidade Jardim  
    Unidade.create :nome => "GRAUNA", :tipo => 3, :regiao_id => 2
    Unidade.create :nome => "ARAUNA", :tipo => 3, :regiao_id => 2
    Unidade.create :nome => "CARANDA", :tipo => 2, :regiao_id => 2
    Unidade.create :nome => "MANAI", :tipo => 2, :regiao_id => 2
    Unidade.create :nome => "ARACATI", :tipo => 2, :regiao_id => 2
    Unidade.create :nome => "CUNHATAI", :tipo => 2, :regiao_id => 2
    Unidade.create :nome => "MARACA", :tipo => 1, :regiao_id => 2
    Unidade.create :nome => "ANAJA", :tipo => 1, :regiao_id => 2
    Unidade.create :nome => "CHUI", :tipo => 1, :regiao_id => 2
# São Vito
    Unidade.create :nome => "MANACA", :tipo => 3, :regiao_id => 3
    Unidade.create :nome => "POTIRA", :tipo => 2, :regiao_id => 3
    Unidade.create :nome => "PATURI", :tipo => 2, :regiao_id => 3
    Unidade.create :nome => "INDAIA", :tipo => 2, :regiao_id => 3
    Unidade.create :nome => "BATUIRA", :tipo => 2, :regiao_id => 3
    Unidade.create :nome => "JACINA", :tipo => 2, :regiao_id => 3
    Unidade.create :nome => "CURIMA", :tipo => 1, :regiao_id => 3
    Unidade.create :nome => "MAJOI", :tipo => 1, :regiao_id => 3
    Unidade.create :nome => "TAPERA", :tipo => 1, :regiao_id => 3
# Zanaga
    Unidade.create :nome => "CURIO", :tipo => 3, :regiao_id => 4
    Unidade.create :nome => "TARAGUA", :tipo => 3, :regiao_id => 4
    Unidade.create :nome => "URUPE", :tipo => 3, :regiao_id => 4
    Unidade.create :nome => "PATATIVA", :tipo => 2, :regiao_id => 4
    Unidade.create :nome => "ARACARI", :tipo => 2, :regiao_id => 4
    Unidade.create :nome => "CURUMIM", :tipo => 2, :regiao_id => 4
# Jardim Ipiranga
    Unidade.create :nome => "TAHIRA", :tipo => 3, :regiao_id => 5
    Unidade.create :nome => "BORE", :tipo => 2, :regiao_id => 5
    Unidade.create :nome => "CECI", :tipo => 2, :regiao_id => 5
    Unidade.create :nome => "CORIMBO", :tipo => 2, :regiao_id => 5
    Unidade.create :nome => "TANGARA", :tipo => 2, :regiao_id => 5
# Centro
    Unidade.create :nome => "BACURI", :tipo => 2, :regiao_id => 6
    Unidade.create :nome => "SABIA", :tipo => 2, :regiao_id => 6
# Praia Azul
    Unidade.create :nome => "PITANGA", :tipo => 3, :regiao_id => 7
    Unidade.create :nome => "PANAMBY", :tipo => 3, :regiao_id => 7
    Unidade.create :nome => "CIEP ZANAGA", :tipo => 5, :regiao_id => 4
    Unidade.create :nome => "CIEP SAO JERONIMO", :tipo => 5 , :regiao_id => 1
    Unidade.create :nome => "CIEP CIDADE JARDIM", :tipo => 5, :regiao_id => 2
    Unidade.create :nome => "CIEP SAO VITO", :tipo => 5, :regiao_id => 3
    Unidade.create :nome => "CIEP JAGUARI", :tipo => 5, :regiao_id => 3
    Unidade.create :nome => "CIEP PRAIA AZUL", :tipo => 5, :regiao_id => 7
    Unidade.create :nome => "CAIC", :tipo => 4 , :regiao_id => 1
    Unidade.create :nome => "EMEF PAULO FREIRE", :tipo => 4, :regiao_id => 2
    Unidade.create :nome => "EMEF FLORESTAN FERNANDES", :tipo => 4, :regiao_id => 6
    Unidade.create :nome => "EMEF DARCY RIBEIRO", :tipo => 4 , :regiao_id => 1
    Unidade.create :nome => "SEDUC", :tipo => 3 , :regiao_id => 1
    Unidade.create :nome => "SUPERVISAO", :tipo => 7, :regiao_id => 22
    Unidade.create :nome => "SEM SEDE", :tipo => 7, :regiao_id => 22
  end

  def self.down
    drop_table :unidades
  end
end
