class MensagemsController < ApplicationController
  before_filter :login_required
  before_filter :load_users
  # GET /mensagems
  # GET /mensagems.xml
  layout :define_layout

  def define_layout
      current_user.layout
  end


  def index
    @entrada = Mensagem.paginate(:all,:page=>params[:page],:per_page =>10,:conditions => ['((para = ? and geral = 1)) and lido = 0', current_user.id])
    @saida = Mensagem.all(:conditions => ['user_id = ? and para is not null', current_user.id])
    @lidas = Mensagem.paginate(:all,:page=>params[:page],:per_page =>10,:conditions => ['((para = ? and geral = 1)) and lido = 1', current_user.id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mensagems }
    end
  end

  def saida
    @mensagems = Mensagem.paginate(:all,:page=>params[:page],:per_page =>10,:conditions => ['user_id = ? and para is not null', current_user.id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mensagems }
    end
  end

  def lidas
    @lidas = Mensagem.paginate(:all,:page=>params[:page],:per_page =>10,:conditions => ['((para = ? and geral = 1)) and lido = 1', current_user.id])
  end

  def entrada
    @mensagems = Mensagem.paginate(:all,:page=>params[:page],:per_page =>10,:conditions => ['((para = ? and geral = 1)) and lido = 0', current_user.id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mensagems }
    end

  end

  # GET /mensagems/1
  # GET /mensagems/1.xml
  def show
    @mensagem = Mensagem.find(params[:id])
    Mensagem.update_all(["lido = ?",true], :id => params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mensagem }
    end
  end

  # GET /mensagems/new
  # GET /mensagems/new.xml
  def new
    @mensagem = Mensagem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mensagem }
    end
  end

  # GET /mensagems/1/edit
  def edit
    @mensagem = Mensagem.find(params[:id])
  end

  # POST /mensagems
  # POST /mensagems.xml
  def create
    @mensagem = Mensagem.new(params[:mensagem])
    @mensagem.user_id = current_user.id
    if @mensagem.para.nil?
      @users = User.all
      @users.each do |mensagem|
        @msg = Mensagem.new
          @msg.user_id = current_user
          @msg.geral = 1
          @msg.para = mensagem.id
          @msg.titulo = @mensagem.titulo
          @msg.texto = @mensagem.texto
        @msg.save
      end
      flash[:notice] = 'Mensagem enviada para todos usuários.'
      redirect_to(@msg)
    else
    respond_to do |format|
      if @mensagem.save
        flash[:notice] = 'Mensagem was successfully created.'
        format.html { redirect_to(@mensagem) }
        format.xml  { render :xml => @mensagem, :status => :created, :location => @mensagem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mensagem.errors, :status => :unprocessable_entity }
      end
    end
   end
  end

  # PUT /mensagems/1
  # PUT /mensagems/1.xml
  def update
    @mensagem = Mensagem.find(params[:id])

    respond_to do |format|
      if @mensagem.update_attributes(params[:mensagem])
        flash[:notice] = 'Mensagem was successfully updated.'
        format.html { redirect_to(@mensagem) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mensagem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mensagems/1
  # DELETE /mensagems/1.xml
  def destroy
    @mensagem = Mensagem.find(params[:id])
    @mensagem.destroy

    respond_to do |format|
      format.html { redirect_to(mensagems_url) }
      format.xml  { head :ok }
    end
  end


  def message_read
    Mensagem.update_all(["lido = ?",true], :id => params[:message_ids])
    redirect_to entrada_mensagems_path
  end

  def message_unread
    Mensagem.update_all(["lido = ?",false], :id => params[:message_ids])
    redirect_to lidas_mensagems_path
  end


  private

  def load_users
    @user_de = User.all(:conditions => ['id = ?', current_user.id])
    @user_para = User.all
  end

end
