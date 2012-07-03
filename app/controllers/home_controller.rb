class HomeController < ApplicationController

  
  before_filter :login_required
  before_filter :load_professors
  layout :define_layout

  def define_layout
    #if Date.today >= ("2010-11-08").to_date
    #  "consulta"
    #else
      current_user.layout
    #end
  end

  def index
    configuration
  end

  def configuration
    @config = Configuration.find_by_user_id(current_user.id)
    if @config.present?
      if @config.data
        $data = @config.data.strftime("%Y")
	session[:data] = @config.data.strftime("Y")
        $data2 = (($data).to_i - 1)
        session[:data2] = (session[:data].to_i - 1)
        $existe = 0
        $conta = 0
        session[:config_id] = @config
        flash[:letivo] = "Ano Vigente: #{@config.data.strftime("%Y").to_s}"
      end
      if @config.begin_period ? session[:begin_period] = @config.begin_period : session[:begin_period] = "-07-01"
      end
      if @config.end_periods ? session[:end_period] = @config.end_periods : session[:end_period] = "-06-30"
      end
    else
        session[:begin_period] = "-07-01"
        session[:end_period] = "-06-30"
        $data = Time.current.strftime("%Y")
	session[:data] = Time.current.strftime("%Y")
        $data2 = (($data).to_i - 1)
        session[:data2] = ((session[:data]).to_i - 1)
        $existe = 0
        $conta = 0
        flash[:notice] =  "Ano Vigente: Ano corrente"
    end
  end


  def login
    if !logged_in? then
      redirect_to(new_session_path)
    else
      render :controller => 'sessions', :action => 'destroy'
    end
  end

  def gen_user
      render :update do |page|
        page.replace_html 'conteudo', :partial => 'usuarios'
      end

  end

  def config
      render :update do |page|
        page.replace_html 'conteudo', :partial => 'configuracao'
      end
  end

def contato
end





  def calc

    @teste = ContactForm.new(params[:teste])
    

      render :update do |page|
        page.replace_html 'teste', :text => 'Foi executado a stored Calcula_pontuacao'
      end

  end

  def load_professors
    @professors = Professor.find(:all, :order => "matricula")
  end



def contato
# se o método é get, o formulário ainda não foi enviado, mostramos o form vazio
if request.get?
@contact = ContactForm.new
else
# aqui recebemos o formulário por post, vamos criar o nosso objeto
# usando os parâmetros vindos do formulário
@contact = ContactForm.new( params['contact'] )
# o método save (que foi sobreescrito) vai ativar a validação
if @contact.save
# se está tudo OK com os dados, vamos enviar o e-mail e...
GenericMailer.deliver_contact_me @contact
# ... redirecionar mostrando uma mensagem
display_message 'Sua mensagem foi enviada com sucesso!', 'app-ok', '/mostrar/contato'
end
end
end



end
