class TitulacaosController < ApplicationController
#require_role "supervisao", :for => :destroy # don't allow contractors to destroy
require_role ["supervisao","direcao","admin","planejamento"], :for => :update # don't allow contractors to destroy
before_filter :login_required
before_filter :load_titulos
  # GET /titulacaos
  # GET /titulacaos.xml
layout :define_layout

  def define_layout
      current_user.layout
  end


  def index
  if (params[:search].nil? || params[:search].empty?)
      @titulacaos = Titulacao.find(:all, :order =>  'descricao ASC')
   else
      @titulacaos = Titulacao.find(:all, :conditions => ["descricao like ?", "%" + params[:search].to_s + "%"])
   end
     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulacaos }
    end
  end

  # GET /titulacaos/1
  # GET /titulacaos/1.xml
  def show
    @titulacao = Titulacao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacao }
    end
  end

  # GET /titulacaos/new
  # GET /titulacaos/new.xml
  def new
    @titulacao = Titulacao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacao }
    end
  end

  # GET /titulacaos/1/edit
  def edit
    @titulacao = Titulacao.find(params[:id])
  end

  # POST /titulacaos
  # POST /titulacaos.xml
  def create
    @titulacao = Titulacao.new(params[:titulacao])

    respond_to do |format|
      if @titulacao.save
        flash[:notice] = 'Titulação cadastrada com sucesso.'
        format.html { redirect_to(@titulacao) }
        format.xml  { render :xml => @titulacao, :status => :created, :location => @titulacao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /titulacaos/1
  # PUT /titulacaos/1.xml
  def update
    @titulacao = Titulacao.find(params[:id])
    @at_log = Log.new
    @at_log.titulacao_id = @titulacao.id
    @at_log.obs = "Atualizado"
    @at_log.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
    @at_log.user_id = current_user.id
    @at_log.save

    respond_to do |format|
      if @titulacao.update_attributes(params[:titulacao])
        flash[:notice] = 'Titulacao was successfully updated.'
        format.html { redirect_to(@titulacao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /titulacaos/1
  # DELETE /titulacaos/1.xml
  def destroy
    @titulacao = Titulacao.find(params[:id])
    @titulacao.destroy

    respond_to do |format|
      format.html { redirect_to(titulacaos_url) }
      format.xml  { head :ok }
    end
  end

def load_titulos
  @titulos = Titulacao.find(:all, :order => "descricao")
end

def desc


  @titulo_desc = Titulacao.find(:all, :conditions => {:id => params[:titulacao_id]})

  if not @titulo_desc.empty? then
   
   $contador=0
     render :update do |page|
       page.insert_html :bottom , 'desc_titulo', :text =>  "Código: " + (Titulacao.find_by_id(params[:titulacao_id]).id).to_s     + " - Descrição do Título: " + (Titulacao.find_by_id(params[:titulacao_id]).descricao).to_s + '<br/>'
     end
  end

end
end
