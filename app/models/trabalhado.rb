class Trabalhado < ActiveRecord::Base
belongs_to :professor
has_many :fichas

  validates_presence_of :ano, :message => ' -  ANO CORRESPONDENTE - ANO JÁ CADASTRADO NA BASE'
  validates_presence_of :professor_id, :message => ' -  TITULO - PREENCHIMENTO OBRIGATÓRIO'
  validates_numericality_of :dias, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :unidade, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :outro_trab, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :f_abonada, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :atestado, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :f_justif, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :f_injustif, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :lic_saude, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'
  validates_numericality_of :afastamento, :greater_than_or_equal_to => 0, :message => ' -  APENAS VALORES POSITIVOS'



  before_create :calcular_valores_dias_trabalhados
  before_update :recalcular_valores_dias_trabalhados
  before_destroy :delete_tempo_trabalhado


  protected

  def calcular_valores_dias_trabalhados
      self.dias_trab = (self.dias - (self.f_abonada + self.atestado + self.f_justif + self.f_injustif + self.lic_saude + self.afastamento))
      if self.unidade == 0
        self.dias_unidade = 0
      else
        self.dias_unidade = self.unidade - (self.f_abonada + self.atestado + self.f_justif + self.f_injustif + self.lic_saude + self.afastamento)
      end
      self.dias_rede = self.dias + self.outro_trab

    if self.ano == ((((Date.today).strftime("%Y")).to_i) - 1)
      @trab_ant = Trabalhado.find_by_professor_id(self.professor_id, :conditions => 'ano = ' + (((self.ano).to_i) + 1).to_s + ' and ano_letivo = ' + (self.ano_letivo).to_s)
      if !(@trab_ant.nil?)
        verificando = ((self.f_abonada) + (self.atestado) + (self.lic_saude) + (self.outras_ausencias))
        if ((self.f_abonada + @trab_ant.f_abonada) + (self.atestado + @trab_ant.atestado) + (self.lic_saude + @trab_ant.lic_saude) + (self.outras_ausencias + @trab_ant.outras_ausencias))  <= 15
          self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
          @trab_ant.dias_efetivos = @trab_ant.dias - (@trab_ant.f_justif + @trab_ant.f_injustif + @trab_ant.afastamento)
          @trab_ant.save
        else
          self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
          @trab_ant.dias_efetivos = @trab_ant.dias - (@trab_ant.f_abonada + @trab_ant.lic_saude + @trab_ant.f_justif + @trab_ant.f_injustif + @trab_ant.afastamento + @trab_ant.outras_ausencias)
          @trab_ant.save
        end
      else
        if ((self.f_abonada) + (self.atestado) + (self.lic_saude) + (self.outras_ausencias))  <= 15
          self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
        else
          self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
        end
      end
    else
      if self.ano == ((((Date.today).strftime("%Y")).to_i))
        @trab_atual = Trabalhado.find_by_professor_id(self.professor_id, :conditions => 'ano = ' + (((self.ano).to_i) - 1).to_s + ' and ano_letivo = ' + (self.ano_letivo).to_s)
        if !(@trab_atual.nil?)
          if ((self.f_abonada + @trab_atual.f_abonada) + (self.atestado + @trab_atual.atestado) + (self.lic_saude + @trab_atual.lic_saude + (self.outras_ausencias + @trab_atual.outras_ausencias)))  <= 15
            self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
            @trab_atual.dias_efetivos = @trab_atual.dias - ( @trab_atual.f_justif + @trab_atual.f_injustif+ @trab_atual.afastamento)
            @trab_atual.save
          else
            self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
            @trab_atual.dias_efetivos = @trab_atual.dias - (@trab_atual.f_abonada + @trab_atual.atestado + @trab_atual.lic_saude + @trab_atual.f_justif + @trab_atual.f_injustif + @trab_atual.afastamento + @trab_atual.outras_ausencias)
            @trab_atual.save
          end
        else
          if ((self.f_abonada) + (self.atestado) + (self.lic_saude) + (self.outras_ausencias))  <= 15
            self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
          else
            self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
          end
        end
      end
    end
  end

  def recalcular_valores_dias_trabalhados
    if self.call_back == 0
      self.dias_trab = (self.dias - (self.f_abonada + self.atestado + self.f_justif + self.f_injustif + self.lic_saude + self.afastamento))
      if self.unidade == 0
        self.dias_unidade = 0
      else
        self.dias_unidade = self.unidade - (self.f_abonada + self.atestado + self.f_justif + self.f_injustif + self.lic_saude + self.afastamento)
      end
      self.dias_rede = self.dias + self.outro_trab

      if self.ano == ((((Date.today).strftime("%Y")).to_i) - 1)
        @trab_ant = Trabalhado.find_by_professor_id(self.professor_id, :conditions => 'ano = ' + (((self.ano).to_i) + 1).to_s + ' and ano_letivo = ' + (self.ano_letivo).to_s)
        if !(@trab_ant.nil?)
          if ((self.f_abonada + @trab_ant.f_abonada) + (self.atestado + @trab_ant.atestado) + (self.lic_saude + @trab_ant.lic_saude) + (self.outras_ausencias + @trab_ant.outras_ausencias))  <= 15
            self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
            @trab_ant.dias_efetivos = @trab_ant.dias - (@trab_ant.f_justif + @trab_ant.f_injustif + @trab_ant.afastamento)
            @trab_ant.call_back = 1
            @trab_ant.save
          else
            self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
            @trab_ant.dias_efetivos = @trab_ant.dias - (@trab_ant.f_abonada + @trab_ant.lic_saude + @trab_ant.f_justif + @trab_ant.f_injustif + @trab_ant.afastamento + @trab_ant.outras_ausencias)
            @trab_ant.call_back = 1
            @trab_ant.save
          end
        else
          if ((self.f_abonada) + (self.atestado) + (self.lic_saude) + (self.outras_ausencias))  <= 15
            self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
          else
            self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
          end
        end
      else
        if self.ano == ((((Date.today).strftime("%Y")).to_i))
          @trab_atual = Trabalhado.find_by_professor_id(self.professor_id, :conditions => 'ano = ' + (((self.ano).to_i) - 1).to_s + ' and ano_letivo = ' + (self.ano_letivo).to_s)
          if !(@trab_atual.nil?)
            verificando = ((self.f_abonada + @trab_atual.f_abonada) + (self.atestado + @trab_atual.atestado) + (self.lic_saude + @trab_atual.lic_saude +  + self.outras_ausencias))  <= 15
            if ((self.f_abonada + @trab_atual.f_abonada) + (self.atestado + @trab_atual.atestado) + (self.lic_saude + @trab_atual.lic_saude) + (self.outras_ausencias + @trab_atual.outras_ausencias))  <= 15
              self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
              @trab_atual.dias_efetivos = @trab_atual.dias - (@trab_atual.f_justif + @trab_atual.f_injustif + @trab_atual.afastamento)
              @trab_atual.call_back = 1
              @trab_atual.save
            else
              self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
              @trab_atual.dias_efetivos = @trab_atual.dias - (@trab_atual.f_abonada + @trab_atual.atestado + @trab_atual.lic_saude + @trab_atual.f_justif + @trab_atual.f_injustif + @trab_atual.afastamento + @trab_atual.outras_ausencias)
              @trab_atual.call_back = 1
              @trab_atual.save
            end
          else
            if ((self.f_abonada) + (self.atestado) + (self.lic_saude) + (self.outras_ausencias))  <= 15
              self.dias_efetivos = self.dias - (self.f_justif + self.f_injustif + self.afastamento)
            else
              self.dias_efetivos = self.dias - (self.f_abonada + self.atestado + self.lic_saude + self.f_justif + self.f_injustif + self.afastamento + self.outras_ausencias)
            end
          end
        end
      end
    end
  end

  def delete_tempo_trabalhado
    if self.ano == ((((Date.today).strftime("%Y")).to_i) - 1)
      @trab_ant = Trabalhado.find_by_professor_id(self.professor_id, :conditions => 'ano = ' + (((self.ano).to_i) + 1).to_s + ' and ano_letivo = ' + (self.ano_letivo).to_s)
      if !(@trab_ant.nil?)
        if ((@trab_ant.f_abonada) + (@trab_ant.atestado) + (@trab_ant.lic_saude) + (@trab_ant.outras_ausencias))  <= 15
          @trab_ant.dias_efetivos = @trab_ant.dias - (@trab_ant.f_justif + @trab_ant.f_injustif + @trab_ant.afastamento)
          @trab_ant.call_back = 1
          @trab_ant.save
        else
          @trab_ant.dias_efetivos = @trab_ant.dias - (@trab_ant.f_abonada + @trab_ant.lic_saude + @trab_ant.f_justif + @trab_ant.f_injustif + @trab_ant.afastamento + @trab_ant.outras_ausencias)
          @trab_ant.call_back = 1
          @trab_ant.save
        end
      end
    else
      if self.ano == ((((Date.today).strftime("%Y")).to_i))
        @trab_atual = Trabalhado.find_by_professor_id(self.professor_id, :conditions => 'ano = ' + (((self.ano).to_i) - 1).to_s + ' and ano_letivo = ' + (self.ano_letivo).to_s)
        if !(@trab_atual.nil?)
          if ((@trab_atual.f_abonada) + (@trab_atual.atestado) + (@trab_atual.lic_saude) + (@trab_atual.outras_ausencias))  <= 15
            @trab_atual.dias_efetivos = @trab_atual.dias - (@trab_atual.f_justif + @trab_atual.f_injustif + @trab_atual.afastamento)
            @trab_atual.call_back = 1
            @trab_atual.save
          else
            @trab_atual.dias_efetivos = @trab_atual.dias - (@trab_atual.f_abonada + @trab_atual.atestado + @trab_atual.lic_saude + @trab_atual.f_justif + @trab_atual.f_injustif + @trab_atual.afastamento + @trab_atual.outras_ausencias)
            @trab_atual.call_back = 1
            @trab_atual.save
          end
        end
      end
    end
  end

  def self.check(professor,ano_letivo)
    find_by_professor_id(professor, :conditions => ["ano_letivo = ?", ano_letivo], :select => "sum(dias_trab) as soma_trab,sum(dias_efetivos) as soma_efet, sum(dias_rede) as soma_rede,sum(dias_unidade) as soma_unid")
  end

end
