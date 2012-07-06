class Professor < ActiveRecord::Base
has_one :acum_trab, :dependent => :destroy
belongs_to :unidade, :class_name => "Unidade", :foreign_key => "sede_id"
has_many :trabalhados, :dependent => :destroy
has_many :fichas, :dependent => :destroy
has_many :titulo_professors
has_many :remocaos, :dependent => :destroy
before_save :muisculizar
validates_presence_of :matricula, :message => ' -  MATRÍCULA - PREENCHIMENTO OBRIGATÓRIO'
validates_presence_of :nome, :message => ' -  NOME - PREENCHIMENTO OBRIGATÓRIO'
validates_presence_of :funcao, :message => ' -  FUNÇÃO - PREENCHIMENTO OBRIGATÓRIO'
validates_presence_of :sede_id, :message => ' -  SEDE - PREENCHIMENTO OBRIGATÓRIO'

validates_numericality_of :INEP, :only_integer => true, :message =>  ' - SOMENTE NÚMEROS'
validates_numericality_of :RD, :only_integer => true, :message =>  ' - SOMENTE NÚMEROS'
validates_uniqueness_of :matricula, :message => ' - PROFESSOR JA CADASTRADO'
Curso = ['Sem Magistério / Pedagogia','Magistério - Nível Médio','Pedagogia / Normal Superior','Licenciatura em Artes','Licenciatura em Educação Física','Licenciatura em Letras - Português','Licenciatura em Letras - Inglês','Licenciatura em Matemática','Licenciatura em História','Licenciatura em Geografia','Licenciatura em Ciências / Biologia']

  def maiusculizar
    self.pontuacao_final = (self.total_trabalhado + self.total_titulacao)
    self.nome.upcase!
    self.endres.upcase!
    self.bairro.upcase!
    self.complemento.upcase!
    self.cidade.upcase!
    self.funcao.upcase!
    self.obs.upcase!
  end

  after_create :log_cadastro
  before_update :atualiza

  def atualiza
   atualiza = Professor.find(self.id)
   if self.dt_nasc.nil?
        self.dt_nasc = atualiza.dt_nasc
   end
   if self.dt_ingresso.nil?
        self.dt_ingresso = atualiza.dt_ingresso
   end

  end


  def log_cadastro
    @atualiza_log = Log.new
    @atualiza_log.user_id = self.log_user
    @atualiza_log.professor_id = self.id
    @atualiza_log.obs = "Cadastrado um professor"
    @atualiza_log.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
    @atualiza_log.save
   
  end

  def self.sub_total_dt
    return $soma_st_dt
  end

  def self.sub_total_de
    return $soma_st_de
  end

  def self.sub_total_dr
    return $soma_st_dr
  end

  def self.sub_total_du
    return $soma_st_du
  end

  def self.calculos
  end

  def self.pontuacao_final(id)
    
    Professor.find(id).pontuacao_final
  end

  def self.insercao_completa(id)
    Trabalhado.find_all_by_professor_id(id)
  end

  def self.total(unidade)
    Professor.find_all_by_sede_id(unidade).count
  end

  def self.look_for_all
    find(:all)
  end

end
