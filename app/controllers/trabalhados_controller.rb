class TrabalhadosController < ApplicationController
  # GET /trabalhados
  # GET /trabalhados.xml
  before_filter :login_required
  before_filter :load_professors
  before_filter :professor_unidade
  before_filter :ano

  require_role ["supervisao","admin","direcao","planejamento"], :for => [:destroy]
  layout :define_layout

  def define_layout
    current_user.layout
  end

  def professor_unidade
    if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
      @professor_sede = Professor.find(:all, :order => 'matricula')
    else
      @professor_sede = Professor.find(:all, :conditions => ['sede_id = ' + current_user.regiao_id.to_s + ' or sede_id = 54'], :order => 'matricula')
    end
  end


  def index
    @busca_trab  = Trabalhado.find_all_by_professor_id((params[:professor].match(/\d+/).to_s).to_i, :conditions => ["flag = 0 and ano_letivo = ?", $data.to_s]) if params[:professor].present?
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @trabalhados }
    end
  end

  # GET /trabalhados/1
  # GET /trabalhados/1.xml
  def show
    @trabalhado = Trabalhado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @trabalhado }
    end
  end

  # GET /trabalhados/new
  # GET /trabalhados/new.xml
  def new
    @trabalhado = Trabalhado.new
        $acum_dias_trab_ano = 0
     $acum_dias_efet_ano = 0
     $acum_dias_rede_ano = 0
     $acum_dias_unid_ano = 0

     $ano_anterior_dias_trab = 0
     $ano_anterior_dias_efet  = 0
     $ano_anterior_dias_rede  = 0
     $ano_anterior_dias_unid  = 0

     $ano_atual_dias_trab = 0
     $ano_atual_dias_efet  = 0
     $ano_atual_dias_rede  = 0
     $ano_atual_dias_unid  = 0

     $total_trab_g = 0
     $total_efet_g = 0
     $total_rede_g = 0
     $total_unid_g = 0

     $dias_trab_ano = 0
     $tot_dias_trab = 0
     $st_dt = 0
     $st_de = 0
     $st_dr = 0
     $st_du = 0
     $soma_st_dt = 0
     $soma_st_de = 0
     $soma_st_dr = 0
     $soma_st_du = 0

     $pont_trab = 0
     $pont_efet = 0
     $pont_rede = 0
     $pont_unid = 0

     $total_trab = 0
     $total_efet = 0
     $total_rede = 0
     $total_unid = 0

    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @trabalhado }
    end
  end

  # GET /trabalhados/1/edit
  def edit
    $id = params[:id]
    @trabalhado = Trabalhado.find(params[:id])



  end

  # POST /trabalhados
  # POST /trabalhados.xml
  def create
    @trabalhado = Trabalhado.new(params[:trabalhado])
    @trabalhado.ano_letivo = $data
    if $ano != $data then
      @trabalhado.remocao = 0
    end
    if @trabalhado.remocao == true then
      @trabalhado.unidade = 0      
    end
    @log = Log.new
    @log.log(current_user.id, @trabalhado.professor_id, "Criado tempo de serviço.Ano:#{@trabalhado.ano} - Ano letivo: #{@trabalhado.ano_letivo}")
    @log.save!
    respond_to do |format|
      if @trabalhado.save
        flash[:notice] = 'TEMPO DE SERVIÇO CADASTRADO COM SUCESSO.'
        format.html { redirect_to(new_trabalhado_path) }
        format.xml  { render :xml => @trabalhado, :status => :created, :location => @trabalhado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @trabalhado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trabalhados/1
  # PUT /trabalhados/1.xml
  def update
    @trabalhado = Trabalhado.find(params[:id])
    @trabalhado.flag = 0
    @trabalhado.call_back = 0
    @log = Log.new
    @log.log(current_user.id, @trabalhado.professor_id, "Atualizado tempo de serviço. Ano :#{@trabalhado.ano} - Ano letivo: #{@trabalhado.ano_letivo}")
    respond_to do |format|
      if @trabalhado.update_attributes(params[:trabalhado])
        flash[:notice] = 'TEMPO DE SERVIÇO ATUALIZADO COM SUCESSO'

        format.html { redirect_to trabalhados_path(:professor => session[:professor]) }

        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @trabalhado.errors, :status => :unprocessable_entity }
      end
    end
   end




  # DELETE /trabalhados/1
  # DELETE /trabalhados/1.xml
  def destroy
    @trabalhado = Trabalhado.find(params[:id])
    @trabalhado.call_back = false
    @trabalhado.destroy
    @log = Log.new
    @log.log(current_user.id, @trabalhado.professor_id, "Excluído um tempo de serviço. Ano :#{@trabalhado.ano} - Ano letivo: #{@trabalhado.ano_letivo}")

    respond_to do |format|
      format.html { redirect_to(trabalhados_url(:professor => session[:professor])) }
      format.xml  { head :ok }
    end
  end

  def sel_prof
     $exibe_dias_trab_ano = 0
     $exibe_dias_efet_ano = 0
     $exibe_dias_rede_ano = 0
     $exibe_dias_unid_ano = 0

     $exibe_dias_ant_trab_ano = 0
     $exibe_dias_ant_efet_ano = 0
     $exibe_dias_ant_rede_ano = 0
     $exibe_dias_ant_unid_ano = 0

     $exibe_dias_trab_ano = 0
     $exibe_dias_efet_ano = 0
     $exibe_dias_rede_ano = 0
     $exibe_dias_unid_ano = 0

     $exibe_ano_anterior_dias_trab = 0
     $exibe_ano_anterior_dias_efet  = 0
     $exibe_ano_anterior_dias_rede  = 0
     $exibe_ano_anterior_dias_unid  = 0

     $exibe_ano_atual_dias_trab = 0
     $exibe_ano_atual_dias_efet  = 0
     $exibe_ano_atual_dias_rede  = 0
     $exibe_ano_atual_dias_unid  = 0

     $exibe_tot_geral_trab = 0
     $exibe_tot_geral_efet = 0
     $exibe_tot_geral_rede = 0
     $exibe_tot_geral_unid = 0

     $dias_trab_ano = 0
     $tot_dias_trab = 0
     $st_dt = 0
     $st_de = 0
     $st_dr = 0
     $st_du = 0
     $soma_st_dt = 0
     $soma_st_de = 0
     $soma_st_dr = 0
     $soma_st_du = 0

     $exibe_pont_trab = 0
     $exibe_pont_efet = 0
     $exibe_pont_rede = 0
     $exibe_pont_unid = 0

     $exibe_tot_trab = 0
     $exibe_tot_efet = 0
     $exibe_tot_rede = 0
     $exibe_tot_unid = 0

     $dias_trab_ano = 0
     $tot_dias_trab = 0
     $st_dt = 0
     $st_de = 0
     $st_dr = 0
     $st_du = 0
     $soma_st_dt = 0
     $soma_st_de = 0
     $soma_st_dr = 0
     $soma_st_du = 0
     $teacher = 0

# =======================================
#|| Inicio Calculos de Tempo de Serviço  ||
# =======================================

    $teacher = params[:trabalhado_professor_id].to_i
    session[:professor] = params[:trabalhado_professor_id].to_i
    @two_times = Trabalhado.find_all_by_professor_id(session[:professor], :conditions => ["flag = 0 and ano_letivo = ?", $data.to_s])
    if @two_times.count == 2
      @ano = []
    end
    if !($teacher.nil?) or !($teacher == '') then
      if (Professor.find($teacher)).nil? then
         $teacher_id = 0
          render :update do |page|
            page.replace_html 'nomeprof', :text => 'Matricula não cadastrada'
            page.replace_html 'pont_initial', :text => ''
            page.replace_html 'visualizar', :text => ''
            page.replace_html 'teste11' ,:text => ''
            page.replace_html 'teste' ,:text => ''
            page.replace_html 'ano', :partial => "ano"
          end
      else
        $teacher_id = $teacher
        $professor_id =  $teacher_id
        @acum = AcumTrab.find(:all, :conditions => ['professor_id = ' + ($teacher_id).to_s])
        for tot_dias in @acum
          $anterior_dias_trab = tot_dias.tot_acum_trab.to_i
          $anterior_dias_efet = tot_dias.tot_acum_efet.to_i
          $anterior_dias_rede = tot_dias.tot_acum_rede.to_i
          $anterior_dias_unid = tot_dias.tot_acum_unid.to_i
          $acum_dias_trab_ano = tot_dias.tot_acum_trab.to_i
          $acum_dias_efet_ano = tot_dias.tot_acum_efet.to_i
          $acum_dias_rede_ano = tot_dias.tot_acum_rede.to_i
          $acum_dias_unid_ano = tot_dias.tot_acum_unid.to_i
        end
        @dias_trab_anterior = Trabalhado.find(:all, :conditions => ['ano = ' + $data2.to_s + ' and professor_id= ' + ($teacher_id).to_s + ' and flag = 0'])
          for ano_anterior in @dias_trab_anterior
            ano_anterior.dias_trab
            $ano_anterior_dias_trab = ano_anterior.dias_trab
            $ano_anterior_dias_efet = ano_anterior.dias_efetivos
            $ano_anterior_dias_rede = ano_anterior.dias_rede
            $ano_anterior_dias_unid = ano_anterior.dias_unidade
          end
        @dias_trab_atual = Trabalhado.find(:all, :conditions => ['ano = ' + $data.to_s + ' and professor_id= ' + ($teacher_id).to_s + ' and flag = 0'])
          for ano_atual in @dias_trab_atual
            ano_atual.dias_trab
            $ano_atual_dias_trab = ano_atual.dias_trab
            $ano_atual_dias_efet = ano_atual.dias_efetivos
            $ano_atual_dias_rede = ano_atual.dias_rede
            $ano_atual_dias_unid = ano_atual.dias_unidade
          end
          $total_trab_g = $acum_dias_trab_ano + $ano_anterior_dias_trab + $ano_atual_dias_trab
          $total_efet_g = $acum_dias_efet_ano + $ano_anterior_dias_efet + $ano_atual_dias_efet
          $total_rede_g = $acum_dias_rede_ano + $ano_anterior_dias_rede + $ano_atual_dias_rede
          $total_unid_g = $acum_dias_unid_ano + $ano_anterior_dias_unid + $ano_atual_dias_unid
          @acum_pont = AcumTrab.find(:all, :conditions => ['professor_id= ' + ($teacher_id).to_s])
          for pontuacao in @acum_pont
            $pont_trab = pontuacao.pont_base_trab
            $pont_efet = pontuacao.pont_base_efet
            $pont_rede = pontuacao.pont_base_rede
            $pont_unid = pontuacao.pont_base_unid
          end
          $total_trab = $pont_trab * $total_trab_g
          $total_efet = $pont_efet * $total_efet_g
          $total_rede = $pont_rede * $total_rede_g
          $total_unid = $pont_unid * $total_unid_g
# =======================================
#|| Fim Calculos de Tempo de Serviço     ||
# =======================================


      @professors = Professor.find(:all, :conditions => ['id=' + ($teacher_id).to_s ])
      @t = Trabalhado.find(:all, :conditions => ['professor_id=' +($teacher_id).to_s])
      @nome_professor = Professor.find_by_id($teacher_id)
      @tp = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + ($teacher_id).to_s + " and t.tipo = 'PERMANENTE'")
      @tp1 = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + ($teacher_id).to_s + " and t.tipo = 'ANUAL'")
      @tp5 = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + ($teacher_id).to_s + " and t.tipo = '5 ANOS'")


      nomeprofessor = Professor.find_by_id($teacher_id).nome             
    @trabalho = Trabalhado.find_by_sql("SELECT * FROM trabalhados where professor_id = " + $teacher_id.to_s + " and ano_letivo = " + $data.to_s)
    @tr = Trabalhado.find(:all, :conditions => ['professor_id=' +($teacher_id).to_s + ' and (flag = 1 ) and ano_letivo = ' + $data.to_s])
    $cont = @tr.count
      if $cont == 2 then
        $existe = 1
        $visualizar = 1
        $voltar = 1
        @inicial = AcumTrab.find(:all, :conditions => ['professor_id = ' + $teacher_id.to_s])
        @professores = Professor.find(:all,:conditions => ['id = ' + $teacher_id.to_s])
        if !@professores.empty? or !@professores.nil? then

        if @inicial.empty? then
          render :update do |page|
            page.replace_html 'pont_initial', :partial => 'initial'
            page.replace_html 'visualizar', :text => ''
            page.replace_html 'visualizar', :partial => 'visualizar'
            page.replace_html 'teste11' ,:partial=> 'relatorio_tps'
            page.replace_html 'teste' ,:text => 'Favor incluir pontuação inicial antes de continuar'
            page.replace_html 'nomeprof', :text => 'Nome: ' + (nomeprofessor).to_s
            page.replace_html 'ano', :partial => "ano"
          end
        else

        render :update do |page|
            page.replace_html 'existe', :text => 'Operações para este professor já concluídas para este ano.'
            page.replace_html 'pont_initial', :text => ''
            page.replace_html 'visualizar', :text => ''
            page.replace_html 'visualizar', :partial => 'visualizar'
            page.replace_html 'teste11' ,:partial=> 'relatorio_tps'
            page.replace_html 'voltar' ,:partial=> 'voltar'
            page.replace_html 'nomeprof', :text => 'Nome: ' + (nomeprofessor).to_s
            page.replace_html 'ano', :partial => "ano"
          end
        end
        end
      else
        $existe = 0
        $voltar = 1
        $visualizar = 1
        @inicial = AcumTrab.find(:all, :conditions => ['professor_id = ' + $teacher_id.to_s])
        @professores = Professor.find(:all,:conditions => ['id = ' + $teacher_id.to_s])
        if !(@professores.empty?) then
        if @inicial.empty? then
          render :update do |page|
            page.replace_html 'pont_initial', :partial => 'initial'
            page.replace_html 'visualizar', :text => ''
            page.replace_html 'visualizar', :partial => 'visualizar'
            page.replace_html 'total' ,:text => 'Favor incluir pontuação inicial'
            page.replace_html 'nomeprof', :text => 'Nome: ' + (nomeprofessor).to_s
            page.replace_html 'ano', :partial => "ano"
          end
        else
          render :update do |page|
            page.replace_html 'pont_initial', :text => ''
            page.replace_html 'visualizar', :text => ''
            page.replace_html 'visualizar', :partial => 'visualizar'
            page.replace_html 'teste11' ,:partial=> 'relatorio_tps'
            page.replace_html 'nomeprof', :text => 'Nome: ' + (nomeprofessor).to_s
            page.replace_html 'ano', :partial => "ano"
          end
        end
        else
          render :update do |page|
           page.replace_html 'nomeprof', :text => 'Matricula não cadastrada'
           page.replace_html 'pont_initial', :text => ''
           page.replace_html 'visualizar', :text => ''
           page.replace_html 'teste11' ,:text => ''
           page.replace_html 'teste' ,:text => ''
           page.replace_html 'ano', :partial => "ano"
          end
        end
      end
      end
  end
end

  def verifica_ano
    $ano = (params[:trabalhado_ano]).to_s
    @verifica_ano = (Trabalhado.find_by_sql("SELECT ano FROM trabalhados where professor_id= " + ($teacher_id.to_s) + " and ano = " + $ano.to_s + " and ano_letivo = " + $data.to_s))
    if !@verifica_ano.empty? then

      render :update do |page|
        page.replace_html 'existe', :text => 'Tempo de serviço já cadastrado para este período( ' + $ano.to_s + ' ). Favor selecione outro Ano.'
        page.replace_html 'voltar', :text => ''
        page.replace_html 'voltar', :partial => 'voltar'
        page.replace_html 'remocao', :text => ''
        page.replace_html 'pont_initial', :text => ''
      end
    else
    if $ano == $data then
      render :update do |page|
        page.replace_html 'remocao', :partial => 'remocao'
        page.replace_html 'voltar', :text => ''
      end
    else

      render :update do |page|
          #page.replace_html 'nome_aviso', :text => 'Tempo de serviço já cadastrado para este período( ' + $ano + ' ). Favor selecione outro Ano'
        page.replace_html 'voltar', :text => ''      
      end    
    end
    end

  end

  def primeira_inclusao
    @acum_trab = AcumTrab.find(:all, :conditions => ['professor_id=' + $teacher_id.to_s])
    if (@acum_trab).nil? or (@acum_trab).empty? then
      @acum_trab = AcumTrab.new
      render :partial => 'tempo_servico_valores_iniciais'
      
      
    else
      render :text => 'DADOS JÁ CADASTRADO'
    end
  end

  def busca_trab
    $prof_id = params[:altera_professor_id]
    @busca_trab = Trabalhado.find_by_sql("SELECT * FROM trabalhados where professor_id = " + $prof_id + " and flag = 0 and ano_letivo = " + $data.to_s)

      render :update do |page|
        page.replace_html 'index', :partial => 'alterar_apagar'
      end
  end

protected

  def load_professors
    @professors = Professor.find(:all, :order => 'matricula')
  end

  def ano
    unless Configuration.find_by_user_id(current_user.id).nil?
      @data_config = Configuration.find_by_user_id(current_user.id).data.strftime("%Y")
      @ano = ["#{@data_config}", "#{((@data_config.to_i) -1)}"]
    else
      @ano = [$data,$data2]
    end
  end


end