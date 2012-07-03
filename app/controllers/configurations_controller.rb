class ConfigurationsController < ApplicationController
  # GET /configurations
  # GET /configurations.xml
  before_filter :login_required
  def index
    if current_user.login == "administrador"
      @configurations = Configuration.all
    else
      @configurations = Configuration.all(:conditions => ["user_id = ?", current_user])
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @configurations }
    end
  end

  # GET /configurations/1
  # GET /configurations/1.xml
  def show
    @configuration = Configuration.find(params[:id])
    flash[:letivo] = "Ano Vigente: #{@configuration.data.strftime("%Y").to_s}"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @configuration }
    end
  end

  # GET /configurations/new
  # GET /configurations/new.xml
  def new
    @configuration = Configuration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @configuration }
    end
  end

  # GET /configurations/1/edit
  def edit
    @configuration = Configuration.find(params[:id])
  end

  # POST /configurations
  # POST /configurations.xml
  def create
    @configuration = Configuration.new(params[:configuration])
    flash[:letivo] = "Ano Vigente: #{@configuration.data.strftime("%Y").to_s}"
    @configuration.user_id = current_user
    respond_to do |format|
      if @configuration.save
        flash[:notice] = 'Data base do Sistema configurada.'
        format.html { redirect_to(@configuration) }
        format.xml  { render :xml => @configuration, :status => :created, :location => @configuration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /configurations/1
  # PUT /configurations/1.xml
  def update
    @configuration = Configuration.find(params[:id])
    flash[:letivo] = "Ano Vigente: #{@configuration.data.strftime("%Y").to_s}"
    respond_to do |format|
      if @configuration.update_attributes(params[:configuration])
        flash[:notice] = 'Data base do Sistema atualizada.'
        format.html { redirect_to(@configuration) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configuration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /configurations/1
  # DELETE /configurations/1.xml
  def destroy
    @configuration = Configuration.find(params[:id])
    @configuration.destroy
    session[:config_id] = nil
    respond_to do |format|
      format.html { redirect_to(configurations_url) }
      format.xml  { head :ok }
    end
  end
end
