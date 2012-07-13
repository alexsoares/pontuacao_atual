
class TituloProfessor < ActiveRecord::Base
  validates_presence_of :professor_id, :message => ' -  PROFESSOR - PREENCHIMENTO OBRIGATÓRIO'
  validates_presence_of :titulo_id, :message => ' -  TITULO - PREENCHIMENTO OBRIGATÓRIO'
  validates_numericality_of :quantidade,:if => :verify_qtd?, :message => ' - Acima de 30 hrs'
  validate :verify_qtd?
  validate :existe_config
  belongs_to :professor
  belongs_to :titulo, :class_name => 'Titulacao', :foreign_key => "titulo_id"
  attr_accessor :user, :current, :begin_period, :end_period, :soma
  #   1 - Distancia
  #   0 - Presencial

  before_save :verifica_tipo_titulo, :verifica_valor_titulos
  before_destroy :atualiza_valor_total_apos_delecao


  def existe_config
    @existe = Configuration.find_by_user_id(self.user)
    if @existe.present?
      unless (@existe.data).nil?
        @existe.data
      end
    else
      Date.current
    end
  end
  def distancia_p
    self.tipo_curso
  end

  def valores_a_distancia(professor,ano_letivo)
    titulos_distancia = TituloProfessor.find(:all, :conditions => ['professor_id = ? and tipo_curso = 0 and ano_letivo = ? and validade = 0 and titulo_id in (7)',professor,ano_letivo], :select => [:pontuacao_titulo])
    somatoria = 0
    titulos_distancia.each do |z|
      somatoria = somatoria + z.pontuacao_titulo
    end
    somatoria
  end

  def self.qtos_titulos(professor,ano_letivo)
    find(:all, :conditions => ['professor_id = ? and tipo_curso = 0 and ano_letivo = ? and validade = 0 and titulo_id in (7)',professor,ano_letivo], :select => [:pontuacao_titulo])
  end


protected
  def verify_qtd?
    if !(self.tipo_curso == true) and self.titulo_id == 7
      if self.quantidade < 30
        errors.add(:tipo_curso, 'Curso à distancia somente acima de 30 hrs de duração')
      end
    end
  end

  def verifica_tipo_titulo
    if (self.titulo_id).between?(1, 5)
      self.quantidade = 1
    end

  end


  def verifica_valor_titulos
      self.obs.upcase!
      self.ano_letivo = existe_config.strftime("%Y")
      if self.titulo_id == 6
        self.tipo_curso = 1
      end
      @titulacao = Titulacao.find(self.titulo_id)
      @atualiza_professor = Professor.find(self.professor_id)
      self.valor = @titulacao.valor
      if (self.titulo_id == 1) or (self.titulo_id == 2) or (self.titulo_id == 3) or (self.titulo_id == 4) or (self.titulo_id == 5)
        self.pontuacao_titulo = self.quantidade * self.valor
        self.status = 1
        @atualiza_professor.total_titulacao = @atualiza_professor.total_titulacao + self.pontuacao_titulo
        @atualiza_professor.save
      else
        @dta = ((existe_config.strftime("%Y").to_i) - 1).to_s + self.begin_period
        if self.dt_titulo < @dta.to_date
          self.status = 0
        else
          if (self.titulo_id == 6) or (self.titulo_id == 7) or (self.titulo_id == 8)
           #self.dt_titulo = (DTA.strftime("%Y").to_i).to_s + "-06-30"
           self.dt_validade = ((existe_config.strftime("%Y").to_i)).to_s + self.end_period
           #self.dt_validade = "2010"
           if self.tipo_curso == false
             somatoria_distancia = valores_a_distancia(self.professor_id, self.ano_letivo)
             pontuacao_nova = (@titulacao.valor * self.quantidade)
             if pontuacao_nova > 0.180
               pontuacao_nova = 0.180
             end
             self.soma = pontuacao_nova + somatoria_distancia
             unless self.soma > 0.180
               self.pontuacao_titulo = pontuacao_nova
             else
               if somatoria_distancia != 0.180
                 if pontuacao_nova < somatoria_distancia
                  self.pontuacao_titulo =(0.180 - somatoria_distancia).abs
                 else
                  self.pontuacao_titulo = (0.180 - somatoria_distancia).abs
                 end
               else
                 self.pontuacao_titulo = 0
               end
             end
           else
             self.pontuacao_titulo = self.quantidade * self.valor
           end
          if (self.dt_titulo.to_s > (existe_config.strftime("%Y").to_s + self.end_period)) or (self.dt_titulo.to_s < (existe_config.strftime("%Y").to_i - 1).to_s + self.begin_period)
             self.status = 0
           else
             @atualiza_professor.total_titulacao = @atualiza_professor.total_titulacao + self.pontuacao_titulo
             @atualiza_professor.save
             self.status = 1
           end
          end
        end
      end
  end


  def atualiza_valor_total_apos_delecao
    if self.status == true
      @prof_total_trabalhado = Professor.find(self.professor_id)
      @prof_total_trabalhado.total_titulacao = @prof_total_trabalhado.total_titulacao - self.pontuacao_titulo
      @prof_total_trabalhado.pontuacao_final = @prof_total_trabalhado.total_titulacao + @prof_total_trabalhado.total_trabalhado
      @prof_total_trabalhado.save
    end
  end

  def self.titulo_permanente(professor)
    TituloProfessor.all(:joins => :titulo, :conditions => ['professor_id = ? and titulacaos.tipo = "PERMANENTE"',professor])
  end

  def self.titulo_anual(professor)
    TituloProfessor.all(:joins => :titulo, :conditions => ['professor_id = ? and titulacaos.tipo = "ANUAL"',professor])
  end


  #professor_current busca professores para os usuários "administrador" "planejamento" "supervisao"
  def self.professor_current(professor)
    Professor.all(:conditions => ['id= ?', professor])
  end

  #professor_normal busca professores para os outros usuários
  def self.professor_normal(professor,regiao)
    Professor.all(:conditions => ['id = ? and (sede_id = ? and sede_id = 54)',professor,regiao])
  end

  def self.professor_consulta_titulo_permanente(titulo,regiao)
    Professor.all(:joins => :titulo_professors, :conditions =>['titulo_professors.titulo_id = ? and (p.sede_id = ? or p.sede_id = 54)', titulo,regiao],:select => "DISTINCT professors.*")
  end

  def self.professor_consulta_titulo_anual(titulo,regiao,ano_letivo)
    Professor.all(:joins => :titulo_professors, :conditions =>['titulo_professors.titulo_id = ? and titulo_professors.ano_letivo = ? and (p.sede_id = ? or p.sede_id = 54)', titulo,ano_letivo,regiao],:select => "DISTINCT professors.*",:page=>params[:page],:per_page =>2)
  end

  def self.verify(professor,ano_letivo,titulo)
    if (titulo == 1 or titulo == 2 or titulo == 3 or titulo == 4 or titulo == 5) then
      TituloProfessor.find(:all,:joins => :titulo, :conditions => ['titulacaos.id = ? and professor_id = ? and ano_letivo = ?',titulo,professor])
    else
      @tp = TituloProfessor.find(:all,:joins => :titulo, :conditions => ['titulacaos.id = ? and professor_id = ? and ano_letivo = ?',titulo,professor,ano_letivo])
    end

  end

  def self.check_titulos(ano_letivo,professor)
   find_by_professor_id(professor,:joins => :professor, :select => "professors.total_titulacao as total_titulacao, professors.total_trabalhado as total_trabalhado, professors.pontuacao_final as pontuacao_final, sum(pontuacao_titulo) as soma_pont_titulo", :conditions => ["(titulo_id in (1,2,3,4,5) or ( ano_letivo = ? and status = 1))",ano_letivo])
  end

end
