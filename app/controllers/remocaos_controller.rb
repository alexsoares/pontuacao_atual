
class RemocaosController < ApplicationController
  before_filter :load_prof
  before_filter :load_uni
  before_filter :load_unidades
  before_filter :login_required
  require_role ["supervisao","admin","planejamento"], :for => [:update,:destroy] # don't allow contractors to destroy
  # GET /remocaos
  # GET /remocaos.xml
  layout :define_layout

  def define_layout
    if logged_in?
      'application'
    else
      "exibicao"
    end

      #current_user.layout
  end

  def load_uni
    @uni_rem = Unidade.find(:all, :order => "nome")
  end

  def load_unidades
    @unidades = Unidade.find(:all, :order => "nome")
  end


  def index

    @remocaos = Remocao.find(:all,:include => :professor ,:conditions => ["ano_letivo = ? and flag_remocao_finalizada = 0", session[:data]], :order => :created_at)

        session[:data] = Time.current.strftime("%Y")
        $data = Time.current.strftime("%Y")
        session[:data2] =  ((session[:data]).to_i - 1)
        $data2 =  ((session[:data]).to_i - 1)


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @remocaos }
    end
  end

  # GET /remocaos/1
  # GET /remocaos/1.xml
  def show
    @remocao = Remocao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @remocao }
    end
  end

  # GET /remocaos/new
  # GET /remocaos/new.xml
  def new
    @remocao = Remocao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @remocao }
    end
  end

  # GET /remocaos/1/edit
  def edit
    @remocao = Remocao.find(params[:id])
  end

  # POST /remocaos
  # POST /remocaos.xml
  def create
    @remocao = Remocao.new(params[:remocao])
    @remocao.ano_letivo = session[:data]
    @remocao.letivo = session[:data]? session[:data] : $data
    @remocao.ano_anterior = session[:data2]? session[:data2] : $data2
    @remocao.ano_atual = session[:data]? session[:data] : $data

    @remocao.professor_id = $id_professor

    respond_to do |format|
      if @remocao.save
        flash[:notice] = 'PROFESSOR INSERIDO EM REMOÇÃO.'
        format.html { redirect_to(@remocao) }
        format.xml  { render :xml => @remocao, :status => :created, :location => @remocao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @remocao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /remocaos/1
  # PUT /remocaos/1.xml
  def update
    @remocao = Remocao.find(params[:id])
    @remocao.letivo = session[:data]? session[:data] : $data
    @remocao.ano_anterior = session[:data2]? session[:data2] : $data2
    @remocao.ano_atual = session[:data]? session[:data] : $data

    respond_to do |format|
      if @remocao.update_attributes(params[:remocao])
        flash[:notice] = 'Remocao efetuada com sucesso.'
        format.html { redirect_to(@remocao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @remocao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /remocaos/1
  # DELETE /remocaos/1.xml<%#
# To change this template, choose Tools | Templates
# and open the template in the editor.
#%>

#<%= "_remocao_dados.html" %>

  def destroy
    @remocao = Remocao.find(params[:id])
    @remocao.destroy

    respond_to do |format|
      format.html { redirect_to(remocaos_url) }
      format.xml  { head :ok }
    end
  end


  def verifica_ano

  end

  def load_prof
    @professores = Professor.find(:all,:order => "matricula")
  end

 def nome_professor
     $professor_rem = params[:remocao_professor_id]
     if !($professor_rem).nil? or !($professor_rem).empty? or !($professor_rem == '')
      $id_professor = $professor_rem
     end

    #$nome_professor = Professor.find(:all, :conditions => ["id = " + $id_professor.to_s])
    @teste = Trabalhado.find_by_sql("select t.professor_id from professors p left join trabalhados t on p.id=t.professor_id where t.ano_letivo = " + session[:data].to_s + " and t.professor_id = " + $id_professor)
    if (@teste.nil?) or (@teste.empty?)
      @teste2 = 0
          render :update do |page|
            page.replace_html 'professor',  :text => "Professor: " + $nome_professor.to_s + ".Este professor ainda não lançou os dias relativos ao ano letivo correspondente."
            page.replace_html 'rem', :text => " Favor inserir todos os dados."
            page.replace_html 'voltar', :partial => "cadastrar"
            page.replace_html 'desapear', :text => ""
          end

    else
      @nome_professor = Professor.find_by_sql("SELECT * FROM professors where id = " + $id_professor.to_s)
      for i in @nome_professor
        $nome_professor = i.nome
      end
      @rem_ef = Remocao.find_all_by_professor_id($id_professor, :conditions => ['flag_remocao_finalizada = 0 and ano_letivo = ?', session[:data]])
      if !@rem_ef.empty? then
        for j in @rem_ef
          $teste = (j.remocao_efetivada)
          if j.remocao == 1 and $teste == nil then
#            render :update do |page|
#              page.replace_html 'professor',  :text => "Professor: " + $nome_professor.to_s + '. Este professor ja esta aguardando remocao'
#              page.replace_html 'rem', :text => " Favor Atualizar a situacao do mesmo."
#              page.replace_html 'voltar', :partial => "voltar"
#              page.replace_html 'desapear', :text => ""
#            end
            else if j.remocao == 1 and j.remocao_efetivada == 0 then
              render :update do |page|
                page.replace_html 'professor',  :text => "Professor: " + $nome_professor.to_s
              end
              else if j.remocao == 1 and j.remocao_efetivada == 1 then
                render :update do |page|
                  page.replace_html 'professor',  :text => "Professor: " + $nome_professor.to_s + ". Funcionou"
                end
              end
            end
          end
        end
      else
        render :update do |page|
          page.replace_html 'professor',  :text => "Professor: " + $nome_professor.to_s
        end
      end
    end
  end

  def remocao_sim
    @remocaos_sim = Remocao.find(:all,:include => :professor, :conditions => ["status = 1 and ano_letivo = ?", Time.current.strftime("%Y")], :order => ["type_of,created_at"])
  end

  def lista_remocao
  end

  def ficha_permuta
      if params[:professor].present?
        @professors = Remocao.find_all_by_professor_id($professor, :conditions => ["flag_remocao_finalizada = 0 and type_of = 2"])
      end

  end

  def ficha_remocao
      #render :update do |page|
      #page.replace_html 'remocao', :partial => 'ficha_remocao'
      #end
      if params[:professor].present?
        @professors = Remocao.find_all_by_professor_id($professor, :conditions => ["flag_remocao_finalizada = 0 and type_of = 1"])
      end

  end


  def efetiva_rem
    $professor_ef = params[:remocao_professor_id]
    @rem_ef = Remocao.find_all_by_professor_id($professor_ef)

    for i in @rem_ef
      if @rem_ef.remocao == 1 and @rem_ef.remocao_efetiva.nil? then
        render :text => 'Este professor já está aguardando remoção'
      end
    end

  end

  def dados_professor

     $exibe_dias_trab_ano = 0
     $exibe_dias_efet_ano = 0
     $exibe_dias_rede_ano = 0
     $exibe_dias_unid_ano = 0

     $exibe_dias_ant_trab_ano = 0
     $exibe_dias_ant_efet_ano = 0
     $exibe_dias_ant_rede_ano = 0
     $exibe_dias_ant_unid_ano = 0

     $exibe_dias_trab_ano = 0
     $exibe_dias_efet_ano = 0
     $exibe_dias_rede_ano = 0
     $exibe_dias_unid_ano = 0

     $exibe_ano_anterior_dias_trab = 0
     $exibe_ano_anterior_dias_efet  = 0
     $exibe_ano_anterior_dias_rede  = 0
     $exibe_ano_anterior_dias_unid  = 0

     $exibe_ano_atual_dias_trab = 0
     $exibe_ano_atual_dias_efet  = 0
     $exibe_ano_atual_dias_rede  = 0
     $exibe_ano_atual_dias_unid  = 0

     $exibe_tot_geral_trab = 0
     $exibe_tot_geral_efet = 0
     $exibe_tot_geral_rede = 0
     $exibe_tot_geral_unid = 0

     unless logged_in?
        session[:data] = Time.current.strftime("%Y")
        $data = Time.current.strftime("%Y")
        session[:data2] =  ((session[:data]).to_i - 1)
        $data2 = (($data).to_i - 1)
     end


     $professor_mat = params[:ficha][:matricula]
    if params[:professor].present?
      session[:professor] = params[:professor]
    else
      session[:professor]= params[:ficha][:matricula]
    end

     if !(session[:professor]).nil? or !(session[:professor]).empty? or !(session[:professor] == '')

      if !(Professor.find_by_matricula(session[:professor])).nil? then
      session[:professor_id] = Professor.find_by_matricula(session[:professor]).id.to_s


    #@professors = Professor.find(:all, :conditions => ['id=' + $professor ])
    @professors = Remocao.find_all_by_professor_id(session[:professor_id], :conditions => ["flag_remocao_finalizada = 0"])
    #@trabalho1 = Trabalhado.find(:all, :conditions => ['professor_id=' +$professor,'ano_letivo = ' + $data.to_s])
    @trabalho1 = Trabalhado.find_by_sql("SELECT * FROM trabalhados WHERE professor_id = " + session[:professor_id] + " and ano_letivo = " + session[:data].to_s)
    #@trabalho = Trabalhado.find(:all, :conditions => ['professor_id=' +$professor,'ano_letivo = ' + $data.to_s])
    @trabalho = Trabalhado.find_by_sql("SELECT * FROM trabalhados WHERE professor_id = " + session[:professor_id] + " and ano_letivo = " + session[:data].to_s)
    #@t = Trabalhado.find(:all, :conditions => ['professor_id=' +$professor,'ano_letivo = ' + $data.to_s])
    @t = Trabalhado.find_by_sql("SELECT * FROM trabalhados WHERE professor_id = " + session[:professor_id] + " and ano_letivo = " + session[:data].to_s)
    @nome_professor = Professor.find_by_id(session[:professor_id])

    @tp = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + session[:professor_id] + " and t.tipo = 'PERMANENTE'")
    @tp1 = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + session[:professor_id] + " and t.tipo = 'ANUAL'")
    @tp5 = TituloProfessor.find_by_sql("SELECT * FROM titulo_professors tp inner join titulacaos t on tp.titulo_id=t.id where tp.professor_id=" + session[:professor_id] + " and t.tipo = '5 ANOS'")
    $zerar = 1

    if params[:ficha][:type_of].to_i == 2
      render :update do |page|
        page.replace_html 'titula', :text => ''
        page.replace_html 'dados_professor', :partial => 'permuta_dados'
      end
    else
      render :update do |page|
        page.replace_html 'titula', :text => ''
        page.replace_html 'dados_professor', :partial => 'remocao_dados'
      end
     end
  else
    render :text => 'Matricula Não cadastrada'
  end
 else
    render :update do |page|
      page.replace_html 'dados_professor', :text => ''
    end

 end
end

  def opcao1
      @zero = Unidade.find_by_id(params[:sede1_sede_id])
      if @zero.nil? then
        render :text   => ''
      else
        render :text   =>  Unidade.find_by_id(params[:sede1_sede_id]).nome
     end
  end

def opcao2
      @zero = Unidade.find_by_id(params[:sede2_sede_id])
      if @zero.nil? then
        render :text   => ''
      else
        render :text   =>  Unidade.find_by_id(params[:sede2_sede_id]).nome
     end
  end

def opcao3
      @zero = Unidade.find_by_id(params[:sede3_sede_id])
      if @zero.nil? then
        render :text   => ''
      else
        render :text   =>  Unidade.find_by_id(params[:sede3_sede_id]).nome
     end
end


def opcao4
      @zero = Unidade.find_by_id(params[:sede4_sede_id])
      if @zero.nil? then
        render :text   => ''
      else
        render :text   =>  Unidade.find_by_id(params[:sede4_sede_id]).nome
     end
end

def opcao5
      @zero = Unidade.find_by_id(params[:sede5_sede_id])
      if @zero.nil? then
        render :text   => ''
      else
        render :text   =>  Unidade.find_by_id(params[:sede5_sede_id]).nome
     end
end

def opcao6
      @zero = Unidade.find_by_id(params[:sede6_sede_id])
      if @zero.nil? then
        render :text   => ''
      else
        render :text   =>  Unidade.find_by_id(params[:sede6_sede_id]).nome
     end
end

def select_type
  if params[:type_of].to_i == 1
    @professor_remocao = Remocao.find(:all, :include => "professor",:conditions => ["ano_letivo = ? and flag_remocao_finalizada = 0 and type_of = 1", session[:data]], :order => :professor_id)
    render :update do |page|
      page.replace_html 'solicitados', :partial => "lista_solicitados"
    end
  else
    if params[:type_of].to_i == 2
    @professor_permuta = Remocao.find(:all, :include => "professor",:conditions => ["ano_letivo = ? and flag_remocao_finalizada = 0 and type_of = 2", session[:data]], :order => :professor_id)
    render :update do |page|
      page.replace_html 'solicitados', :partial => "lista_solicitados"
    end
    end
  end
end

end



