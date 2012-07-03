# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  layout 'login'
  include AuthenticatedSystem

  # render new.rhtml
  def new
    
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      session[:ip] = request.remote_ip
      #if session[:ip] == '200.232.60.242' or session[:ip] == '201.77.127.49' # or session[:ip] == '201.92.73.126'
        redirect_back_or_default(home_path)      
        flash[:notice] = "BEM VINDO AO SISTEMA PONTUA."
      #else
      #  redirect_to(visaos_path)
      #  flash[:notice] = "O PERIODO DE INSERCAO DE DADOS TERMINOU EM 17 DE AGOSTO"
      #end
    else
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "SISTEMA FINALIZADO. VOLTE SEMPRE."
    redirect_back_or_default('/')
  end
end
