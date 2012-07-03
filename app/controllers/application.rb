# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem


  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  #:secret => 'f98d0606f1ae167a56aff4a76d8842f4'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  # filter_parameter_logging :password
end
TIPO_TITULO = {'PERMANENTE' => 'PERMANENTE', 'ANUAL' => 'ANUAL', '5 ANOS' => '5 ANOS'}
REFERENCIA = {'HORAS' => 'HORAS', 'COMUNICAÇÃO'=>'COMUNICAÇÃO','CURSO'=>'CURSO','TITULO'=>'TITULO'}
SEDE = {'C. Cr. Arapiranga' => 'C. Cr. Arapiranga',
  'C. Cr. Araúna' => 'C. Cr. Araúna',
  'C. Cr. Bitu' => 'C. Cr. Bitu',
  'C. Cr. Curió' => 'C. Cr. Curió',
  'C. Cr. Graúna' => 'C. Cr. Graúna',
  'C. Cr. Juriti' => 'C. Cr. Juriti',
  'C. Cr. Maíra' => 'C. Cr. Maíra',
  'C. Cr. Manacá' => 'C. Cr. Manacá',
  'C. Cr. Panamby' => 'C. Cr. Panamby',
  'C. Cr. Pitanga' => 'C. Cr. Pitanga',
  'C. Cr. Tahira' => 'C. Cr. Tahira',
  'C. Cr. Taraguá' => 'C. Cr. Taraguá',
  'C. Cr. Urupê' => 'C. Cr. Urupê',
  'CAIC' => 'CAIC',
  'CIEP Cidade Jardim' => 'CIEP Cidade Jardim',
  'CIEP Jaguari' => 'CIEP Jaguari',
  'CIEP Praia Azul' => 'CIEP Praia Azul',
  'Ciep São Jerônimo' => 'Ciep São Jerônimo',
  'CIEP São Vito' => 'CIEP São Vito',
  'CIEP Zanaga' => 'CIEP Zanaga',
  'Creche Anajá' => 'Creche Anajá',
  'Creche Chuí' => 'Creche Chuí',
  'Creche Curimã' => 'Creche Curimã',
  'Creche Majoí' => 'Creche Majoí',
  'Creche Maracá' => 'Creche Maracá',
  'Creche Taperá' => 'Creche Taperá',
  'EMEF Darcy Ribeiro' => 'EMEF Darcy Ribeiro',
  'EMEF Florestan Fernandes' => 'EMEF Florestan Fernandes',
  'EMEF Paulo Freire' => 'EMEF Paulo Freire',
  'EMEI Araçari' => 'EMEI Araçari',
  'EMEI Aracati' => 'EMEI Aracati',
  'EMEI Aracy' => 'EMEI Aracy',
  'EMEI Bacuri' => 'EMEI Bacuri',
  'EMEI Batuira' => 'EMEI Batuira',
  'EMEI Boré' => 'EMEI Boré',
  'EMEI Carandá' => 'EMEI Carandá',
  'EMEI Ceci' => 'EMEI Ceci',
  'EMEI Corimbó' => 'EMEI Corimbó',
  'EMEI Cunhataí' => 'EMEI Cunhataí',
  'EMEI Curumim' => 'EMEI Curumim',
  'EMEI Indaiá' => 'EMEI Indaiá',
  'EMEI Jacina' => 'EMEI Jacina',
  'EMEI Jacy' => 'EMEI Jacy',
  'EMEI Manaí' => 'EMEI Manaí',
  'EMEI Patativa' => 'EMEI Patativa',
  'EMEI Paturi' => 'EMEI Paturi',
  'EMEI Potira' => 'EMEI Potira',
  'EMEI Sabiá' => 'EMEI Sabiá ',
  'EMEI Tangará' => 'EMEI Tangará',
  'Tempo de Viver' => 'Tempo de Viver ',
  'Secretaria de Educação'=>'Secretaria de Educação'}

CARGO = {'Diretor Ed. Básica'=> 'Diretor Ed. Básica',
          'Prof. Coordenador'=>'Prof. Coordenador',
          'Pedagogo'=> 'Pedagogo',
          'ADI'=>'ADI',
          'Prof. de Creche'=>'Prof. de Creche',
          'PEB1 - Ed. Infantil'=> 'PEB1 - Ed. Infantil',
          'PEB1 - Ensino Fundamental'=> 'PEB1 - Ensino Fundamental',
          'PEB2 - Artes'=> 'PEB2 - Artes',
          'PEB2 - Ed. Física'=> 'PEB2 - Ed. Física',
          'PEB2 - História'=> 'PEB2 - História',
          'PEB2 - Geografia'=> 'PEB2 - Geografia',
          'PEB2 - Matemática'=> 'PEB2 - Matemática',
          'PEB2 - Português'=> 'PEB2 - Português',
          'PEB2 - Inglês'=> 'PEB2 - Inglês',
          'PEB2 - Ciências'=> 'PEB2 - Ciências',
          'PEB - Ed. Especial'=> 'PEB - Ed. Especial',
          'TODOS' => 'TODOS'
          }
PERIODO = {'Manhã' => 'Manhã', 'Tarde' => 'Tarde', 'Integral' => 'Integral'}
$acao = 0
