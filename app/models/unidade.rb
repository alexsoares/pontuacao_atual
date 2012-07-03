class Unidade < ActiveRecord::Base
  belongs_to :regiao
  has_many :professors
  has_many :users
  named_scope :fundamental, :conditions => ["tipo in (4,5,6,7)"], :order => 'nome ASC'
  named_scope :infantil, :conditions => ["tipo in (1,2,3,7)"], :order => 'nome ASC'
  named_scope :todos, :conditions => ["tipo in (1,2,3,4,5,6,7)"], :order => 'nome ASC'
  def nome_tipo

    if tipo == 1 then
       @teste =  'CRECHE'
    else
    if tipo == 2 then
       @teste =  'EMEI'
    else
    if tipo == 3 then
       @teste =  'CASA DA CRIANÇA'
    else
    if tipo == 4 then
       @teste =  'EMEF'
    else
       @teste = 'CIEP'
    end
    end
    end
    end
  end


  def self.sede(id = nil)
    id ||= "Geral"
    find(id).nome
  end

  def self.funcao(id)
  end
end
