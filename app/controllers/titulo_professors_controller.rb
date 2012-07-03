class TituloProfessorsController < ApplicationController
  before_filter :load_titulacao
  before_filter :load_professors
  before_filter :professor_unidade
  before_filter :login_required
  require_role ["supervisao","planejamento","administrador"], :for_all_except => [:search,:search_by_desc,:search_by_professor_titulos_anuais,:relatorio_titulos_anuais_invalidos,:relatorio_por_descricao_titulo, :relatorio_prof_titulacao,:update, :titulos_busca, :destroy, :index, :new, :create, :sel_prof, :busca_prof, :guarda_valor1, :guarda_valor, :nome_professor]
  # GET /titulo_professors
  # GET /titulo_professors.xml
  layout :define_layout

  def define_layout
      current_user.layout
  end


  #Relatorio por tiulos

  def relatorio_prof_titulacao
    if (params[:titulo_id]).present?
    if (params[:accept]).present?
      @relatorio_tit_prof = TituloProfessor.paginate(:all, :page=>params[:page],:per_page =>20,:conditions => ["titulo_id <> ?",params[:titulo_id][:titulo_id]], :include => ['professor'],:order => 'professors.nome')
    else
      @relatorio_tit_prof = TituloProfessor.paginate(:all, :page=>params[:page],:per_page =>20,:conditions => ["titulo_id = ?", params[:titulo_id][:titulo_id]], :include => ['professor'],:order => 'professors.nome')
    end
   else
     @relatorio_tit_prof = "Selecione um titulo para filtragem"
   end
    render :action => 'relatorio_prof_titulacao'

  end

  def search
  end

#=====================================================================================================================================================================

# Relatorio pela descrição do titulo

  def relatorio_por_descricao_titulo

   if (params[:titulo]).present?
     #@relatorio_por_descricao_titulo = TituloProfessor.obs_like(params[:titulo])
     @relatorio_por_descricao_titulo = TituloProfessor.paginate(:all,:page=>params[:page],:per_page =>20,:conditions => ["obs like ? and titulo_id = 1",params[:titulo]])
   else
     @relatorio_por_descricao_titulo = "Descreva o titulo para filtragem"
   end
    render :action => 'relatorio_por_descricao_titulo'


  end

  def search_by_desc
  end


#====================================================================================================================================================================
# Relatorio titulos anuais invalidos

  def relatorio_titulos_anuais_invalidos
    if (params[:professor_id]).present?
     @relatorio_tit_prof = TituloProfessor.paginate(:all,:page=>params[:page],:per_page =>20,:conditions => ["professor_id = ? and (titulo_id = 6 or titulo_id = 7 or titulo_id = 8) and ano_letivo <> ?",params[:professor_id][:professor_id], Time.current.strftime("%Y")])
   else
     @relatorio_tit_prof = "Selecione o professor"
   end
    render :action => 'relatorio_titulos_anuais_invalidos'
  end

  def search_by_professor_titulos_anuais
  
  end

#====================================================================================================================================================================
  def index
    if params[:professor].present?
      if params[:type].to_i == 1
        @titulo_busca = TituloProfessor.paginate(:all,:page=>params[:page],:per_page =>20,:conditions =>['professor_id = ? and titulo_id in (6,7,8) and ano_letivo = ?',params[:professor],Time.current.strftime("%Y")])
      else
        @titulo_busca = TituloProfessor.paginate(:all,:page=>params[:page],:per_page =>20,:conditions =>['professor_id = ? and (titulo_id in (1,2,3,4,5))',params[:professor]])
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @titulo_professors }
      end
    end
  end

  # GET /titulo_professors/1
  # GET /titulo_professors/1.xml
  def show
    @titulo_professor = TituloProfessor.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulo_professor }
    end
  end

  # GET /titulo_professors/new
  # GET /titulo_professors/new.xml
  def new
    @titulo_professor = TituloProfessor.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulo_professor }
    end
  end

  # GET /titulo_professors/1/edit
  def edit
    @titulo_professor = TituloProfessor.find(params[:id])
  end

  # POST /titulo_professors
  # POST /titulo_professors.xml
  def create
    @titulo_professor = TituloProfessor.new(params[:titulo_professor])
    @titulo_professor.user = current_user.id
    @titulo_professor.current = Time.current
    @titulo_professor.begin_period = "#{session[:begin_period]}"
    @titulo_professor.end_period =  "#{session[:end_period]}"
    @log = Log.new
    @log.log(current_user.id, @titulo_professor.professor_id, "Cadastrado Titulo do professor.")

    respond_to do |format|
      if @titulo_professor.save
        flash[:notice] = 'TITULAÇÂO CADASTRADA COM SUCESSO.'
        format.html { redirect_to(new_titulo_professor_path)}
        format.xml  { render :xml => @titulo_professor, :status => :created, :location => @titulo_professor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulo_professor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /titulo_professors/1
  # PUT /titulo_professors/1.xml
  def update
    @titulo_professor = TituloProfessor.find(params[:id])
    @at_log = Log.new
    @at_log.titulacao_id = @titulo_professor.id
    @at_log.obs = "Atualizado"
    @at_log.professor_id = @titulo_professor.professor_id
    @at_log.user_id = current_user.id
    @at_log.save
    respond_to do |format|
      if @titulo_professor.update_attributes(params[:titulo_professor])
        flash[:notice] = 'TITULO ATUALIZADO COM SUCESSO'
        format.html { redirect_to(titulo_professor_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulo_professor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /titulo_professors/1
  # DELETE /titulo_professors/1.xml
  def destroy
    $r =TituloProfessor.find(params[:id])
    @titulo_professor = TituloProfessor.find(params[:id])
    @at_log = Log.new
    @at_log.titulacao_id = @titulo_professor.id
    @at_log.obs = "Atualizado"
    @at_log.professor_id = @titulo_professor.professor_id
    @at_log.user_id = current_user.id
    @at_log.save
    @titulo_professor.destroy

    respond_to do |format|
      format.html { redirect_to(titulo_professors_path) }
      format.xml  { head :ok }
    end
  end


  def sel_prof
    $teacher = params[:titulo_professor_professor_id]
    session[:teacher] = params[:titulo_professor_professor_id]

    if !($teacher.nil? or $teacher.empty?) or $teacher == '' then
      if (Professor.find($teacher)).nil? then
         render :update do |page|
           page.replace_html 'nomeprof', :text => 'Matricula não cadastrada'
           page.replace_html 'titulos', :text => ''
         end
      else

        #$professor_id = Professor.find_by_matricula($teacher).id
        $professor_id = $teacher
        $id_professor = $professor_id
        $professor = Professor.find($teacher).nome

        @tp = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + ($teacher).to_s + " and t.tipo = 'PERMANENTE'")
        @tp1 = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + ($teacher).to_s + " and t.tipo = 'ANUAL'")
        @tp5 = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + ($teacher).to_s + " and t.tipo = '5 ANOS'")
        render :update do |page|
          page.replace_html 'nomeprof', :text => 'Nome: ' + ($professor)
          page.replace_html 'titulos', :partial => 'mostrar_pont_titulos'
        end
      end
    end
  end

  def busca_prof
    render :update do |page|
      page.replace_html 'titulos', :partial => 'mostrar_pont_titulos'
    end
    $professor_id = nil
    $teacher = nil
  end

  def guarda_valor1

    $id_titulo = params[:titulo_professor_titulo_id]
    $valor = Titulacao.find_by_id($id_titulo).valor

    render :update do |page|
      page.replace_html 'valor', :text => 'O valor do Titulo é: ' + ($valor).to_s
      #page.replace_html 'titulos', :partial => 'totaliza_titulo'
    end


  end

  def guarda_valor

    $id_titulo = params[:titulo_professor_titulo_id]
    $valor = Titulacao.find_by_id($id_titulo).valor

    if $id_titulo.to_i == 7
      render :update do |page|
        page.replace_html 'valor', :text => 'O valor do Titulo é: ' + ($valor).to_s
        #page.replace_html 'tipo_titulo', :partial => 'tipo'
      end
    else
      if $id_titulo.to_i == 1 || $id_titulo.to_i == 2 || $id_titulo.to_i == 3 || $id_titulo.to_i == 4 || $id_titulo.to_i == 5
      render :update do |page|
        page.replace_html "qtde", :text => "1"
        page.replace_html 'valor', :text => 'O valor do Titulo é: ' + ($valor).to_s
      end
      else
      render :update do |page|
        page.replace_html 'valor', :text => 'O valor do Titulo é: ' + ($valor).to_s
      end
      end
    end
  end


  def nome_professor

    $id_professor = params[:titulo_professor_titulo_id]
    $professor = Professor.find_by_id($id_professor).nome

    render :update do |page|
      page.replace_html 'nome', :text => 'Nome:: ' + ($professror)
      #page.replace_html 'titulos', :partial => 'totaliza_titulo'
    end

  end

 def titulos_busca
        #@titulo_busca = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors where professor_id = " + params[:altera_professor_id] + " and (ano_letivo = " + Time.current.strftime("%Y") + " or titulo_id in (1,2,3,4,5))" )
        @titulo_busca = TituloProfessor.paginate(:all,:page=>params[:page],:per_page =>20,:conditions =>['professor_id = ? and (ano_letivo = ? or titulo_id in (1,2,3,4,5))',params[:altera_professor_id],Time.current.strftime("%Y")])
      render :update do |page|
        page.replace_html 'alteracao', :partial => 'alterar'
      end
 end

 protected

  def load_titulacao
    @titulacaos = Titulacao.find(:all)
  end

  def load_professors
    @professors = Professor.find(:all, :order => "matricula ASC")
  end


  def professor_unidade
    if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
      @professor_sede = Professor.all(:order => 'matricula')
    else
      @professor_sede = Professor.all(:conditions => ['sede_id = ' + current_user.regiao_id.to_s + ' or sede_id = 54'], :order => 'matricula')
    end
  end


end

