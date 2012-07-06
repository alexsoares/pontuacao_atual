class UnidadesController < ApplicationController

  before_filter :login_required
  before_filter :load_regiaos
  layout :define_layout

  def define_layout
      current_user.layout
  end

  # GET /unidades
  # GET /unidades.xml
  def load_regiaos
    @regiaos = Regiao.find(:all, :order => "nome")
  end

 def index
   if (params[:search].nil? || params[:search].empty?)
      @unidades = Unidade.paginate(:all,:page=>params[:page],:per_page =>20, :order =>  'nome ASC')
   else
      @unidades = Unidade.paginate(:all,:page=>params[:page],:per_page =>20, :conditions => ["nome like ?", "%" + params[:search].to_s + "%"])
   end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @unidades }
    end
  end

  # GET /unidades/1
  # GET /unidades/1.xml
  def show
    @unidade = Unidade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @unidade }
    end
  end

  # GET /unidades/new
  # GET /unidades/new.xml
  def new
    @unidade = Unidade.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @unidade }
    end
  end

  # GET /unidades/1/edit
  def edit
    @unidade = Unidade.find(params[:id])
  end

  # POST /unidades
  # POST /unidades.xml
  def create
    @unidade = Unidade.new(params[:unidade])

    respond_to do |format|
      if @unidade.save
        flash[:notice] = 'Unidade criada com sucesso.'
        format.html { redirect_to(@unidade) }
        format.xml  { render :xml => @unidade, :status => :created, :location => @unidade }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /unidades/1
  # PUT /unidades/1.xml
  def update
    @unidade = Unidade.find(params[:id])
              @atualiza_log = Log.new
              @atualiza_log.user_id = current_user.id
              @atualiza_log.obs = "Alteração da unidade " + @unidade.id.to_s + " - " +  @unidade.nome.to_s
              @atualiza_log.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
              @atualiza_log.unidade_id = @unidade.id
            @atualiza_log.save

    respond_to do |format|
      if @unidade.update_attributes(params[:unidade])
        flash[:notice] = 'Unidade atualizada com sucesso.'
        format.html { redirect_to(@unidade) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unidade.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /unidades/1
  # DELETE /unidades/1.xml
  def destroy
    @unidade = Unidade.find(params[:id])
              @atualiza_log = Log.new
              @atualiza_log.user_id = current_user.id
              @atualiza_log.obs = "Exclusão da unidade " + @unidade.nome + " " + @unidade.id.to_s
              @atualiza_log.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
              @atualiza_log.unidade_id = @unidade.id
            @atualiza_log.save


    @unidade.destroy

    respond_to do |format|
      format.html { redirect_to(unidades_url) }
      format.xml  { head :ok }
    end
  end
end
