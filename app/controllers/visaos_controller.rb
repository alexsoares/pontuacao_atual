class VisaosController < ApplicationController


  before_filter :load_professors
  layout 'exibicao'
  # GET /visaos
  # GET /visaos.xml
  def index
    if !(params[:tipo]).blank?     
      if params[:tipo].to_s == "Fundamental"
        redirect_to fundamental_visaos_path
      else
        if params[:tipo].to_s == "Infantil"
          redirect_to infantil_visaos_path
        else
          redirect_to ambos_visaos_path
        end
      end
    end
  end


  def geral

  end

  def infantil
    @search = Professor.search(params[:search])
    if !(params[:search].blank?)
        @search = Professor.search(params[:search])
           @professor_rel_geral = @search.all(:include => :unidade, :conditions => ["professors.funcao in ('ADI','Prof. de Creche','PEB1 - Ed. Infantil', 'Prof. Coordenador','Diretor Ed. Básica','Pedagogo')"], :order => 'pontuacao_final DESC,prioridade,dt_ingresso,dt_nasc,n_filhos')
    end
  end

  

  def fundamental
      @search = Professor.search(params[:search])
      if !(params[:search].blank?)
              @search = Professor.search(params[:search])
              @professor_rel_geral = @search.all(:include => :unidade, :conditions => ["professors.funcao in ('PEB1 - Ensino Fundamental','PEB2 - Artes','PEB2 - Inglês','PEB2 - Geografia','PEB2 - Ciências','PEB2 - Português','PEB2 - História','PEB2 - Matemática','PEB2 - Ed. Física','Diretor Ed. Básica','Pedagogo')"], :order => 'pontuacao_final DESC,prioridade,dt_ingresso,dt_nasc,n_filhos')
      end
  end


  def ambos
      @search = Professor.search(params[:search])
      if !(params[:search].blank?)
              @search = Professor.search(params[:search])
              @professor_rel_geral = @search.all(:include => :unidade, :conditions => ["unidades.tipo in (1,2,3,4,5,6,7)"], :order => 'pontuacao_final DESC,prioridade,dt_ingresso,dt_nasc,n_filhos')
      end
  end


  def instrucao
    @instrucao =<<-HEREDOC

    Para imprimir a ficha de pontuação individual dos professores,
       é necessário possuir um login com no mínimo acesso de
       diretor/escola. Siga os seguintes passos:
    No canto superior esquerdo da tela, possui um campo denominado
       "Entrar", ao clicar neste link será solicitado o login e senha
       que já deverá estar cadastrado no sistema. Após logado no sistema
       você será re-direcionado a uma tela semelhante a utilizada durante
       o uso do sistema. Nesta tela existirá a opção:
       "Executar>Pontuacao>Pontuacao" que todos já estão acostumados.
    Ps.: Está opção continua apenas para manter compatibilidade entre
       as versões do sistema.
    A ultima opção deste menu será "Listagem fichas", está será a opção
       que será utilizada. Ao clicar neste item serão listados todas as
       fichas dos professores com a pontuação lançada. Deverá ser digitado
       a matricula do professor no campo de busca e após clicar em buscar
       neste momento será listado apenas a ficha do professor desejado.
       Então clique em "Visualisar", a ficha será montada na tela, e no menu
       "Executar", agora será exibido "Gerar ficha", colocando o mouse sobre
       esta opção será exibida as opções disponíveis no sistema. São elas:
           3 - Imprimir
           2 - Export to PDF
           1 - Voltar => Esta opção retornará o usuário a listagem de fichas.
      Para retornar ao ambiente de consulta dos listões vá em: "Arquivo>Inicio".

               HEREDOC

  end

  protected

  def load_professors
    @unidades = Unidade.all(:order => 'nome ASC')
    @professors = Professor.find(:all,:include => :unidade, :conditions => ["unidades.tipo in (1,2,3)"], :order => "matricula")
  end



end
