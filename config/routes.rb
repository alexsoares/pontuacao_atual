ActionController::Routing::Routes.draw do |map|
  map.resources :configurations

  map.resources :correcaos, :collection => {:find_professor => :get}

  map.resources :announcements, :as => "anuncios"
    
  map.resources :mensagems, :collection => { :saida => :get, :entrada => :get, :message_read => :put, :lidas => :get,:message_unread => :put}

  map.resource :consulta, :collection => {:consulta_titulo => :get, :consulta_ppu => :get, :consulta_geral => :get}

  map.resources :logs

  map.resources :visaos, :as => "visualizacao",:collection => {:fundamental => :get, :infantil => :get, :ambos => :get, :instrucao => :get}

  map.resources :remocaos, :collection => {:ficha_permuta => :get,:dados_professor => :get,:ficha_remocao => :get,:lista_remocao => :get, :remocao_sim => :get}

  map.resources :regiaos

  map.resources :unidades

  map.resources :roles_users, :as => "papel_usuario"

  map.resources :users, :as => "usuarios"

  map.resource :session, :as => "sessao", :path_names => {:new => "nova"}

  map.resources :acum_trabs, :as => "acumulado", :path_names => {:new => "novo", :show => "exibir"}

  map.resources :titulo_professors, :collection => { :relatorio_prof_titulacao => :get, :relatorio_titulos_anuais_invalidos => :get, :relatorio_por_descricao_titulo => :get}

  map.resources :titulacaos

  map.resources :servicos

  map.resources :trabalhados, :as => "tempo_de_servico", :path_names => {:new => "novo", :show => "exibir", :edit => "alterar"}

  map.resources :professors, :as => "professores",:has_many=>:fichas, :collection => { :gerar_ficha => :get, :status => :get, :to_print => :get, :check => :get, :esmiucar_tempo_servico => :get, :esmiucar_titulos => :get, :esmiucar_pontuacao => :get,:esmiucar_status => :get }, :path_names => {:new => "novo"}

  map.resource :password

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "visaos"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
 map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil

map.signup '/signup', :controller => 'users', :action => 'new'

map.login '/login', :controller => 'sessions', :action => 'new'

map.logout '/logout', :controller => 'sessions', :action => 'destroy'

  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.root :controller => "home"
  
  map.acertar_unidade '/acertar_unidade', :controller => 'calculos', :action => 'acertar_unidade'
  map.calculo_dias '/calculo_dias', :controller => 'calculos', :action => 'calcula_pontuacao'
  map.consulta '/consulta', :controller => 'consultas'
  map.relatorio_por_funcao '/relatorio_por_funcao', :controller => 'consultas', :action => 'relatorio_por_funcao'
  map.arrumar_titulos '/calculos/arrumar_titulos', :controller => 'calculos', :action => 'arrumar_titulos'
  map.geo '/calculos/geo', :controller => 'calculos', :action => 'geo'
  map.iniciar_ano '/calculos/iniciar_ano', :controller => 'calculos', :action => 'iniciar_ano'
  map.ficha_automatica '/calculos/ficha_automatica', :controller => 'calculos', :action => 'ficha_automatica'
  map.relatorio_ficha '/calculos/relatorio_ficha', :controller => 'calculos', :action => 'relatorio_ficha'
  map.relatorio_ficha_year '/calculos/relatorio_ficha_year', :controller => 'calculos', :action => 'relatorio_ficha_year'
  map.reset_password '/reset_password/:id', :controller => 'passwords', :action => 'edit'
  map.home '/home', :controller => "home", :as => "inicio"
end
