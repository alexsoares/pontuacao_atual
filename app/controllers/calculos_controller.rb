class CalculosController < ApplicationController
  before_filter :load_professors
  require_role "admin", :except => ['relatorio_ficha']
  #before_filter :login_require

  layout :define_layout

  def define_layout
      current_user.layout
  end

  def index
  end
  
  def calcula_pontuacao
      # se o método é get, o formulário ainda não foi enviado, mostramos o form vazio
    if request.get?
      @calculo = Calculo.new
    else
      # aqui recebemos o formulário por post, vamos criar o nosso objeto
      # usando os parâmetros vindos do formulário
      @calculo = Calculo.new( params['contact'] )
      # o método save (que foi sobreescrito) vai ativar a validação
      Professor.connection.execute("CALL calcula_pontuacao(" + ((@calculo.professor_id).to_s) + ")")
      @trabalho = Trabalhado.find_by_sql("SELECT * FROM trabalhados where professor_id = " + @calculo.professor_id.to_s + " and ano_letivo = " + $data.to_s)
      flash[:notice] = 'CALCULOS REALIZADOS PARA O PROFESSOR: ' + Professor.find(@calculo.professor_id).nome
      render :action => 'dias_calculados'
    end
  end

  def efetivar_iniciar_ano
    @inicia_ano = Professor.find(:all)
    for professor in @inicia_ano
      @acum_prof = AcumTrab.find_all_by_professor_id(professor.id)
      professor.flag = 0
      # titulo_arrumado indica se já foi realizado o processo para invalidação dos titulos anuais
      #professor.titulo_arrumado = 1
      for acum_prof in @acum_prof
        @acum_prof2 = AcumTrab.find(acum_prof.id)
        @acum_prof2.verifica = 2
        #status indica se o calculo para a data foi realizado ou não.
        @acum_prof2.status = 0
        @acum_prof2.save
      end
      professor.save
    end
      render :update do |page|
        page.replace_html 'inicia_ano', :text => "Novo ano iniciado"
      end
    
  end


  def iniciar_ano
  end

  def arrumar_titulos
    @titulos = TituloProfessor.find(:all,:joins => :professor, :conditions => ["(titulo_id = 6 or titulo_id = 7 or titulo_id = 8) and ano_letivo = ? and professors.titulo_arrumado = 1",params[:ano]])
  end


  #Flag titulo_arrumado no BD indica se a atualização para remover os titulos anuais ja foi realizada
  #Tipo booleana
  # 0 - Significa que foi realizado
  # 1 - Significa que ainda deve ser realiza

  def efetiva_arrumar_titulos
    @count = 0
    unless (params[:ano].nil?)
      @id_professor = Professor.all
      for professor in @id_professor
        titulos_anuais = TituloProfessor.sum('pontuacao_titulo', :conditions => ["professor_id = " +(professor.id).to_s + " and (titulo_id = 6 or titulo_id = 7 or titulo_id = 8) and ano_letivo = ?",params[:ano]])
        @professor = Professor.find(professor.id)
        if @professor.titulo_arrumado == true
          @professor.total_titulacao= @professor.total_titulacao - titulos_anuais
          @professor.titulo_arrumado = 0
          @professor.pontuacao_final = @professor.total_titulacao + @professor.total_trabalhado
          @count = @count + 1
        end
        @professor.save
      end
    end
    render :partial => "success"
  end




  def ficha_automatica    
  end

  def efetivar_ficha_automatica
    @professor= Professor.all
    for ficha in @professor
      @log = Log.new
      @log.log(current_user.id, ficha.id, "Criado a ficha de pontuacao via ficha automática para : #{ficha.id} - #{ficha.nome}")
      @log.save!

      @existe = Trabalhado.find_all_by_professor_id(ficha.id, :conditions => ['ano_letivo = ?',$data])
      @possui_ficha = Ficha.find_by_professor_id(ficha.id,:conditions =>['ano_letivo = ?',$data])
      @contagem_finalizada = AcumTrab.find_all_by_professor_id(ficha.id, :conditions => ['status = 1'])

      if @contagem_finalizada.present?
        if !@possui_ficha.present?
          @fichas = Ficha.new
        else
          @fichas = @possui_ficha
        end
          if @existe.count == 2 then

              @fichas.professor_id = ficha.id
              @acum_trab_ficha = AcumTrab.find_by_professor_id(ficha.id)
              @fichas.acum_trab_id = @acum_trab_ficha.id
              @fichas.tot_acum_ant_trab = @acum_trab_ficha.tot_acum_ant_trab
              @fichas.tot_acum_ant_efet = @acum_trab_ficha.tot_acum_ant_efet
              @fichas.tot_acum_ant_rede = @acum_trab_ficha.tot_acum_ant_rede
              @fichas.tot_acum_ant_unid = @acum_trab_ficha.tot_acum_ant_unid
              @fichas.tot_acum_trab = @acum_trab_ficha.tot_acum_trab
              @fichas.tot_acum_efet = @acum_trab_ficha.tot_acum_efet
              @fichas.tot_acum_rede = @acum_trab_ficha.tot_acum_rede
              @fichas.tot_acum_unid = @acum_trab_ficha.tot_acum_unid
              @fichas.tot_geral_trab = @acum_trab_ficha.tot_geral_trab
              @fichas.tot_geral_efet = @acum_trab_ficha.tot_geral_efet
              @fichas.tot_geral_rede = @acum_trab_ficha.tot_geral_rede
              @fichas.tot_geral_unid = @acum_trab_ficha.tot_geral_unid
              @fichas.valor_trab = @acum_trab_ficha.valor_trab
              @fichas.valor_efet = @acum_trab_ficha.valor_efet
              @fichas.valor_rede = @acum_trab_ficha.valor_rede
              @fichas.valor_unid = @acum_trab_ficha.valor_unid
              @fichas.trabalhado_anterior_id = Trabalhado.find_by_professor_id(ficha.id, :conditions => ['ano_letivo = ? and ano = ?',$data, (($data.to_i) -1).to_s]).id
              @fichas.trabalhado_atual_id = Trabalhado.find_by_professor_id(ficha.id, :conditions => ['ano_letivo = ? and ano = ?',$data, $data]).id
              @fichas.total_geral = Professor.find(ficha.id).pontuacao_final
              @fichas.total_titulacao = Professor.find(ficha.id).total_titulacao
              @fichas.total_trabalhado = Professor.find(ficha.id).total_trabalhado
              @fichas.ano_letivo = $data
            @fichas.save
          end
        end
    end    
    @professor_com_ficha = Ficha.paginate(:all,:page=>params[:page],:per_page =>25,:conditions => ['ano_letivo = ?', $data])
    redirect_to(relatorio_ficha_path)

  end
  
  def relatorio_ficha
    @list_year = Ficha.ano
    unless params[:year].nil?
      #@verifica_existencia = Trabalhado.find_by_professor_id(@professor,:joins => "right join professors on trabalhados.professor_id=professors.id ", :conditions => ["ano_letivo = ? and created_at < '2010-01-01 00:00:00'", params[:year]])
      if params[:search].blank?
        if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
          @professor_com_ficha = Ficha.paginate(:all,:joins => :professor,:page=>params[:page],:per_page =>25,:conditions => ['ano_letivo = ?', params[:year]])
        else
          @professor_com_ficha = Ficha.paginate(:all,:joins => :professor,:page=>params[:page],:per_page =>25,:conditions => ['ano_letivo = ? and (professors.sede_id = ? or professors.sede_id = 54)', params[:year], current_user.regiao_id])
        end
      else
        if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
          @professor_com_ficha = Ficha.paginate(:all,:joins => :professor,:page=>params[:page],:per_page =>25,:conditions => ['ano_letivo = ? and professors.matricula = ?', params[:year],params[:search]])
        else
          @professor_com_ficha = Ficha.paginate(:all,:joins => :professor,:page=>params[:page],:per_page =>25,:conditions => ['ano_letivo = ? and (professors.sede_id = ? or professors.sede_id = 54)  and professors.matricula = ?', params[:year], current_user.regiao_id,params[:search]])
        end
      end

    end
  end

  def relatorio_ficha_year
  end

  def acertar_unidade
    #p_u_c => Professores com Unidade Correta
    #p_u_a => Professores com Unidade Antiga
    @arruma_unidade = Professor.find_by_sql("SELECT p_u_c.id, p_u_c.matricula, p_u_c.sede_id as 'ser_corrigida',p_u_c.sede_id_ant, p_u_a.sede_id as 'unidades_corretas' FROM `professors` p_u_c inner join professors2 p_u_a on p_u_c.matricula=p_u_a.matricula where p_u_c.sede_id <> p_u_a.sede_id order by p_u_c.id")

    @arruma_unidade.each do |a_u|
      @professor = Professor.find(a_u)
      @professor.id
      @professor.sede_id = a_u.unidades_corretas
      @professor.save
    end

  end


  protected

  def load_professors
    @professors = Professor.find(:all, :order => "matricula")
    @professor = Professor.find(:all, :include => :fichas)
  end


end

