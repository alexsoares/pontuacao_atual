class CorrecaosController < ApplicationController
  # GET /correcaos
  # GET /correcaos.xml
  def index
    @correcaos = Correcao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @correcaos }
    end
  end

  # GET /correcaos/1
  # GET /correcaos/1.xml
  def show
    @correcao = Correcao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @correcao }
    end
  end

  # GET /correcaos/new
  # GET /correcaos/new.xml
  def new
    @correcao = Correcao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @correcao }
    end
  end

  # GET /correcaos/1/edit
  def edit
    @correcao = Correcao.find(params[:id])
  end

  # POST /correcaos
  # POST /correcaos.xml
  def create
    @correcao = Correcao.new(params[:correcao])
    @correcao.professor_id = params[:professor]
    respond_to do |format|
      if @correcao.save
        flash[:notice] = 'Correcao was successfully created.'
        format.html { redirect_to(@correcao) }
        format.xml  { render :xml => @correcao, :status => :created, :location => @correcao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @correcao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /correcaos/1
  # PUT /correcaos/1.xml
  def update
    @correcao = Correcao.find(params[:id])

    respond_to do |format|
      if @correcao.update_attributes(params[:correcao])
        flash[:notice] = 'Correcao was successfully updated.'
        format.html { redirect_to(@correcao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @correcao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /correcaos/1
  # DELETE /correcaos/1.xml
  def destroy
    @correcao = Correcao.find(params[:id])
    @correcao.destroy

    respond_to do |format|
      format.html { redirect_to(correcaos_url) }
      format.xml  { head :ok }
    end
  end

  def find_professor
    @teste = AcumTrab.find_by_professor_id(params[:contact][:professor])
    render :update do |page|
      page.replace_html 'professor', :text => 'acumulado'
    end

  end
end
