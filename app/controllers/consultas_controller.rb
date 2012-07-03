class ConsultasController < ApplicationController
before_filter :sede_unidade
before_filter :load_titulos
layout :define_layout
helper_method :sort_column, :sort_direction
  def define_layout
      current_user.layout
  end

  def index
  end


  def search
  end

  def relatorio_por_funcao
    @search = Professor.search(params[:search])
    if (params[:search]).present?
      @relatorio_funcao = @search.paginate(:all,:page=>params[:page],:per_page =>20, :order => sort_column + " " + sort_direction)
   else
      @relatorio_funcao = "Selecione uma função"
   end
    render :action => 'relatorio_por_funcao'


  end

  def consulta_ppu
    $tipo_con = 1
    $v = 1
  end

 def consulta_pu
    $tipo_con = 2
    $v = 1
    render :update do |page|
      page.replace_html 'tempo', :text => ''
      page.replace_html 'principal', :partial => 'consultas'
    end
 end

 def consulta_sede
    $sede = params[:p_sede_id]
    if $sede == 54 then
      $sede= 'TODAS UNIDADES'
    else
      @professors = Professor.find_all_by_sede_id($sede)
      @professors = Professor.paginate(:all,:conditions => ['sede_id = ?',$sede],:page=>params[:page],:per_page =>30)
      $professor = Professor.find_all_by_sede_id($sede).object_id

    end
  if $tipo_con == 1 then
   if $sede == 'TODAS UNIDADES' then
      @professorsnome = Professor.paginate(:all, :order => 'nome',:page=>params[:page],:per_page =>30)
    else
     if $sede == 'SELECIONE' then
       @professorsnome = ''
     else
        @professorsnome = Professor.paginate(:all, :conditions => ['sede_id = ?',$sede], :order => 'nome',:page=>params[:page],:per_page =>20)
     end
    end
      render :update do |page|
        page.replace_html 'professores', :partial => 'professor_sede'
      end

  else
   if $tipo_con == 2 then
    if $sede == 'TODAS UNIDADES' then
      @professorsnome = Professor.paginate(:all, :order => 'pontuacao_final DESC',:page=>params[:page],:per_page =>20)
    else
     if $sede == 'SELECIONE' then
       @professorsnome = ''
     else
      @professorsnome = Professor.paginate(:all,:conditions => ['sede_id = ?',$sede], :order => 'pontuacao_final DESC',:page=>params[:page],:per_page =>30)
     end
    end

    render :update do |page|
      page.replace_html 'consultas', :partial => 'lista_consulta_sede'
      page.replace_html 'tempo', :text => ''
      page.replace_html 'nome_consulta', :text => 'Pontuação Professores por Unidade'
    end

   else
   if $tipo_con == 4 then
   if $sede == 'TODAS UNIDADES' then
      @professorsnome = Professor.paginate(:all, :order => 'nome',:page=>params[:page],:per_page =>30)
    else
     if $sede == 'SELECIONE' then
       @professorsnome = ''
     else
        @professorsnome = Professor.paginate(:all,:conditions => ['sede_id = ?',$sede], :order => 'nome',:page=>params[:page],:per_page =>30)
     end
    end
      render :update do |page|
        page.replace_html 'professores', :partial => 'busca_titulacao'
      end
    end
   end
  end
 end

  def consulta_nome
    $professor = params[:pro_professor_id]    
   if $professor.empty? then
    render :update do |page|
      page.replace_html 'tempo', :text => ''
      page.replace_html 'consultas', :text => ''
    end
    else
    if logged_in?
        
        if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
         @professors = TituloProfessor.professor_current(params[:pro_professor_id]).paginate(:page=>params[:page],:per_page =>20)
        else
         @professor = TituloProfessor.professor_normal(params[:pro_professor_id],current_user.regiao_id).paginate(:page=>params[:page],:per_page =>20)
        end
    end
    @tp = TituloProfessor.titulo_permanente(params[:pro_professor_id])
    @tp1 = TituloProfessor.titulo_permanente(params[:pro_professor_id])
    render :update do |page|
      page.replace_html 'consultas', :partial => 'lista_consulta_nomeprofessor'
      page.replace_html 'tempo', :text => ''
      page.replace_html 'nome_consulta', :text => 'Pontuação Professor'
    end
    end
 end

 def consulta_pt
  $tipo_con = 4
  render :update do |page|
    page.replace_html 'tempo', :text => ''
    page.replace_html 'principal', :partial => 'busca_titulacao'
  end
 end

 def consulta_titulo
   if (params[:search].nil? || params[:search].empty?)
      titulo = 0
      $titulo = 0
   else
      titulo = params[:search][:search]
      $titulo = params[:search][:search].to_s
   end
    if $titulo != 0
     if (current_user.regiao_id == 53 or current_user.regiao_id == 52) then
      if (params[:search][:search] == 1 or params[:search][:search] == 2 or params[:search][:search] == 3 or params[:search][:search] == 4 or params[:search][:search] == 5) then
        @professors = Professor.paginate(:all,:joins => :titulo_professors, :conditions =>['titulo_professors.titulo_id = ?', $titulo],:select => "DISTINCT professors.*",:page=>params[:page],:per_page =>2)
      else
        @professors = Professor.paginate(:all,:joins => :titulo_professors, :conditions =>['titulo_professors.titulo_id = ? and titulo_professors.ano_letivo = ?', $titulo,$data],:select => "DISTINCT professors.*",:page=>params[:page],:per_page =>2)
      end
     else
       if (params[:search][:search] == 1 or params[:search][:search] == 2 or params[:search][:search] == 3 or params[:search][:search] == 4 or params[:search][:search] == 5) then
         @professors = TituloProfessor.professor_consulta_titulo_permanente(params[:search][:search],current_user).paginate(:page=>params[:page],:per_page =>2)
       else
         @professors = TituloProfessor.professor_consulta_titulo_anual(params[:search][:search],current_user,$data).paginate(:page=>params[:page],:per_page =>2)
       end
     end
         @professors = Professor.paginate(:all,:joins => :titulo_professors, :conditions =>['titulo_professors.titulo_id = ?', $titulo],:select => "DISTINCT professors.*",:page=>params[:page],:per_page =>2)
         #@professors = Professor.paginate(:all,:joins => :titulo_professors, :conditions =>['titulo_professors.titulo_id = ? and titulo_professors.ano_letivo = ?', $titulo,$data]
         #@professors = TituloProfessor.find(:all, :conditions => ['titulo_id=?',$titulo.to_s])
    end
  end

  def consulta_geral
  $tipo_con = 10
  @professor_rel_geral = Professor.paginate(:all, :order => 'pontuacao_final DESC', :include => 'unidade',:page=>params[:page],:per_page =>20)

#    render :update do |page|
#      page.replace_html 'tempo', :text => ''
#      page.replace_html 'contents', :partial => 'relatorio_geral_pontuacao'
#    end
  end

private

  def sort_column
    Professor.column_names.include?(params[:sort]) ? params[:sort] : "nome"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


 protected
  def sede_unidade
    if current_user.regiao_id == 53 or current_user.regiao_id == 52 then
      @unidade_sede = Unidade.find(:all, :include => "regiao", :order => 'nome ASC')
    else
      @unidade_sede = Unidade.find(:all, :conditions => ['id = ' + current_user.regiao_id.to_s + ' or id = 54'], :include => "regiao", :order => 'nome ASC')
    end
  end

  def load_titulos
    @titulos = Titulacao.find(:all, :order => "descricao")
  end


end
