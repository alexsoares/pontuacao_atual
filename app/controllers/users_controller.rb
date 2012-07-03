class UsersController < ApplicationController

  before_filter :load_unidades
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  layout 'login'

  def logged?
    layout 'application'
  end

  def load_unidades
    @unidades = Unidade.find(:all, :order => "nome")
  end
  def index
  end

  def edit
    @user = current_user
  end

    def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Usuario was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end



  def aviso
      render :update do |page|
        page.replace_html 'loginnn', :partial => 'aviso'
      end

  end

  def listar_user_cad
    render :partial => 'listar_usuarios_cadastrados'
  end


  # render new.rhtml
  def new

  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    Notificador.deliver_notificar(@user)
    @user.save
    if @user.errors.empty?
      self.current_user = @user
            render :action => 'aviso'
      flash[:notice] = "BEM VINDO AO SISTEMA PONTUA."
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "SENHA EFETUADA COM SUCESSO"
    end
    redirect_back_or_default('/')
  end

  def show
    @user = current_user
  end

  def reg_id
    $reg_id = params[:user_regiao_id]
    if $reg_id == '1' then
      render :text => 'Terá acesso a todos as unidades'
    else
      render :text => 'Você terá acesso apenas aos professores da unidade selecionada'
    end
  end

 def destroy
    @user = User.find(params[:id])
    #@user.apagar_papel(@user.id)
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end


end
