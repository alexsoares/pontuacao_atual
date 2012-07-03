class Titulacao < ActiveRecord::Base

has_many :titulo_professors
validates_presence_of :descricao, :message => ' -  DESCRIÇÃO DO TÍTULO  - PREENCHIMENTO OBRIGATÓRIO'
validates_presence_of :tipo, :message => ' -  TIPO DE VALIDADE DO TÍTULO - PREENCHIMENTO OBRIGATÓRIO'
validates_presence_of :referencia, :message => ' -  REFERÊNCIA - PREENCHIMENTO OBRIGATÓRIO'
validates_numericality_of :valor, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'

  def before_save
    self.descricao.upcase!
    self.tipo.upcase!
    self.referencia.upcase!
  end
  

end
