class RegiaosController < ApplicationController
  before_filter :login_required
  require_role ["supervisao","admin","planejamento"]
  layout :define_layout
  helper_method :sort_column, :sort_direction
  
  def define_layout
      current_user.layout
  end

  # GET /regiaos
  # GET /regiaos.xml
  def index
   @search = Regiao.search(params[:search])
   if (params[:search].blank?)
      @regiaos = @search.all( :order =>  sort_column + " " + sort_direction)
   else
      @regiaos = @search.all(:order => sort_column + " " + sort_direction)
   end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @regiaos }
    end
  end

  # GET /regiaos/1
  # GET /regiaos/1.xml
  def show
    @regiao = Regiao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @regiao }
    end
  end

  # GET /regiaos/new
  # GET /regiaos/new.xml
  def new
    @regiao = Regiao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @regiao }
    end
  end

  # GET /regiaos/1/edit
  def edit
    @regiao = Regiao.find(params[:id])
  end

  # POST /regiaos
  # POST /regiaos.xml
  def create
    @regiao = Regiao.new(params[:regiao])

    respond_to do |format|
      if @regiao.save
        flash[:notice] = 'Regiao was successfully created.'
        format.html { redirect_to(@regiao) }
        format.xml  { render :xml => @regiao, :status => :created, :location => @regiao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @regiao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /regiaos/1
  # PUT /regiaos/1.xml
  def update
    @regiao = Regiao.find(params[:id])
              @atualiza_log = Log.new
              @atualiza_log.user_id = current_user.id
              @atualiza_log.obs = "Atualizado"
              @atualiza_log.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
              @atualiza_log.save


    respond_to do |format|
      if @regiao.update_attributes(params[:regiao])
        flash[:notice] = 'Regiao was successfully updated.'
        format.html { redirect_to(@regiao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @regiao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /regiaos/1
  # DELETE /regiaos/1.xml
  def destroy
    @regiao = Regiao.find(params[:id])
              @atualiza_log = Log.new
              @atualiza_log.user_id = current_user.id
              @atualiza_log.obs = "Apagado"
              @atualiza_log.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
              @atualiza_log.regiao_id = @regiao.id
            @atualiza_log.save

    @regiao.destroy

    respond_to do |format|
      format.html { redirect_to(regiaos_url) }
      format.xml  { head :ok }
    end
  end

private

  def sort_column
    Regiao.column_names.include?(params[:sort]) ? params[:sort] : "nome"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  

end
