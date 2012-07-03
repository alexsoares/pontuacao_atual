class RolesUsersController < ApplicationController
  require_role ["admin"]
  before_filter :load_user
  before_filter :load_role
  before_filter :login_required
  # GET /role_users
  # GET /role_users.xml
  layout :define_layout

  def define_layout
      current_user.layout
  end

  def load_user
    @users = User.find_by_sql("SELECT login,id FROM users where id not in (select user_id from roles_users)")
  end

  def listar_user_ass
    render :partial => 'listar_usuarios_associados'
  end

  def load_role
    @roles = Role.find(:all)
    @role_users = RolesUser.find(:all)
  end


  def index
    $new_id = 0
    @role_users = RolesUser.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @role_users }
    end
  end

  # GET /role_users/1
  # GET /role_users/1.xml
  def show
      @role_user = RolesUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role_user }
    end
  end

  # GET /role_users/new
  # GET /role_users/new.xml
  def new
    @role_user = RolesUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role_user }
    end
  end

  # GET /role_users/1/edit
  def edit
    @role_user = RolesUser.find(params[:id])
  end

  # POST /role_users
  # POST /role_users.xml
  def create
    @role_user = RolesUser.new(params[:roles_user])
    @role_user.ativar_usuario(@role_user.user_id)
    respond_to do |format|
      if @role_user.save
        flash[:notice] = 'OK'
        format.html { redirect_to(@role_user) }
        format.xml  { render :xml => @role_user, :status => :created, :location => @role_user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /role_users/1
  # PUT /role_users/1.xml
  def update
    @role_user = RolesUser.find(params[:id])
    @role_user.role_id = $new_role_id
    @role_user.ativar_usuario(@role_user.user_id)
    respond_to do |format|
      if @role_user.update_attributes(params[:role_user])
        flash[:notice] = 'Papel do usuário atualizado com sucesso.'
        format.html { redirect_to(@role_user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /role_users/1
  # DELETE /role_users/1.xml
  def destroy
    @role_user = RolesUser.find(params[:id])
    @role_user.destroy

    respond_to do |format|
      format.html { redirect_to(roles_users_url) }
      format.xml  { head :ok }
    end
  end
  def role_id
    $new_role_id = params[:roles_user_role_id]
    render :text => ''
  end
end