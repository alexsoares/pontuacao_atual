class AcumTrabsController < ApplicationController
before_filter :login_required
before_filter :professor_unidade
  # GET /acum_trabs
  # GET /acum_trabs.xml
 layout :define_layout

  def define_layout
      current_user.layout ? current_user.layout : "application"
  end
  
  def index
    if (params[:search].nil? || params[:search].empty?)
      if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
        if params[:professor].present?
          @listagem = AcumTrab.paginate(:all, :include => 'professor',:page=>params[:page],:per_page =>20,:conditions => ['acum_trabs.status = 0 and professor_id = ?', params[:professor]])
        else
          @listagem = AcumTrab.paginate(:all, :include => 'professor',:page=>params[:page],:per_page =>20,:conditions => ['acum_trabs.status = 0'])
        end
      else
        #      @listagem = AcumTrab.find(:all, :include => 'professor', :conditions => ['status = 0'], :order => "professor_id")
        if params[:professor].present?
          @listagem = AcumTrab.paginate(:all, :include => 'professor',:page=>params[:page],:per_page =>20, :conditions => ['acum_trabs.status = 0 and (professors.sede_id = ? or professors.sede_id = 54) and professor_id = ?',current_user.regiao_id,params[:professor]], :order => "professors.sede_id,professors.nome")
        else
          @listagem = AcumTrab.paginate(:all, :include => 'professor',:page=>params[:page],:per_page =>20, :conditions => ['acum_trabs.status = 0 and (professors.sede_id = ? or professors.sede_id = 54)',current_user.regiao_id], :order => "professors.sede_id,professors.nome")
        end
      end
    else
      if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
        @listagem = AcumTrab.paginate(:all, :include => 'professor',:page=>params[:page],:per_page =>20, :conditions => ['acum_trabs.status = 0 and professors.matricula = ?',params[:search]], :order => "professor_id")
      else
        @listagem = AcumTrab.paginate(:all, :include => 'professor',:page=>params[:page],:per_page =>20, :conditions => ['acum_trabs.status = 0 and (professors.sede_id = ? or professors.sede_id = 54) and professors.matricula = ?',current_user.regiao_id,params[:search]], :order => "professor_id")
      end
#      @listagem = AcumTrab.find(:all, :include => 'professor', :conditions => ['status = 0 and professors.matricula = ?',params[:search]], :order => "professor_id")
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @acum_trabs }
    end
  end

  # GET /acum_trabs/1
  # GET /acum_trabs/1.xml
  def show
    @acum_trab = AcumTrab.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acum_trab }
    end
  end

  # GET /acum_trabs/new
  # GET /acum_trabs/new.xml
  def new
    @acum_trab = AcumTrab.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acum_trab }
    end
  end

  # GET /acum_trabs/1/edit
  def edit
    @acum_trab = AcumTrab.find(params[:id])
    @trabalho = Trabalhado.find(:all, :conditions => ['professor_id = ? and ano_letivo = ?', @acum_trab.professor_id, $data], :order => 'ano')
  end

  # POST /acum_trabs
  # POST /acum_trabs.xml
  def create
    @acum_trab = AcumTrab.new(params[:acum_trab])
    @log = Log.new
    @log.log(current_user.id, @acum_trab.professor_id, "Criado valores acumulados para o professor:#{@acum_trab.professor_id}")

    respond_to do |format|
      if @acum_trab.save
    
        format.html { redirect_to(new_trabalhado_path)}
        format.xml  { render :xml => @acum_trab, :status => :created, :location => @acum_trab }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acum_trab.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /acum_trabs/1
  # PUT /acum_trabs/1.xml
  def update
    @acum_trab = AcumTrab.find(params[:id])
    @log = Log.new
    @log.log(current_user.id, @acum_trab.professor_id, "Realizado calculo dos novos valores para o professor:#{@acum_trab.professor_id}")
     @acum_trab.verifica =0
     $update = 1
    respond_to do |format|
      if @acum_trab.update_attributes(params[:acum_trab])
        #flash[:notice] = 'AcumTrab was successfully updated.'
        format.html { redirect_to(professors_path)}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acum_trab.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /acum_trabs/1
  # DELETE /acum_trabs/1.xml
  def destroy
    @acum_trab = AcumTrab.find(params[:id])
    @log = Log.new
    @log.log(current_user.id, @acum_trab.professor_id, "Deletado valores acumulados.Para o professor:#{@acum_trab.professor_id}")
    @acum_trab.destroy

    respond_to do |format|
      format.html { redirect_to(acum_trabs_url) }
      format.xml  { head :ok }
    end
  end

protected
  def professor_unidade
    if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
      @professor_sede = Professor.find(:all, :order => 'matricula', :include => 'unidade')
    else
      @professor_sede = Professor.find(:all, :conditions => ['sede_id = ' + current_user.regiao_id.to_s + ' or sede_id = 54'], :order => 'matricula', :include => 'unidade')
    end
  end

end
