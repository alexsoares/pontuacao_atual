# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120703095950) do

  create_table "Export_Geral", :id => false, :force => true do |t|
    t.integer "id",                                                            :default => 0,   :null => false
    t.integer "matricula",                                                                      :null => false
    t.string  "nome",                                                                           :null => false
    t.string  "funcao",                                                                         :null => false
    t.decimal "total_trabalhado",               :precision => 10, :scale => 3, :default => 0.0
    t.decimal "total_titulacao",                :precision => 10, :scale => 3, :default => 0.0
    t.decimal "pontuacao_final",                :precision => 10, :scale => 3, :default => 0.0
    t.string  "Unidade"
    t.integer "tot_acum_trab",    :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer "tot_acum_efet",    :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer "tot_acum_rede",    :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer "tot_acum_unid",    :limit => 10, :precision => 10, :scale => 0, :default => 0
  end

  create_table "acum_trab_antigas", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "tot_acum_ant_trab", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_efet", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_rede", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_unid", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_trab",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_efet",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_rede",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_unid",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.decimal  "tot_geral_trab",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "tot_geral_efet",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "tot_geral_rede",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "tot_geral_unid",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_trab",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_efet",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_rede",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_unid",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_trab",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_efet",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_rede",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_unid",                      :precision => 10, :scale => 3, :default => 0.0
    t.integer  "status",                                                         :default => 0,   :null => false
    t.integer  "verifica",                                                       :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acum_trabs", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "tot_acum_ant_trab", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_efet", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_rede", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_unid", :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_trab",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_efet",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_rede",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_unid",     :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.decimal  "tot_geral_trab",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "tot_geral_efet",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "tot_geral_rede",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "tot_geral_unid",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_trab",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_efet",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_rede",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pont_base_unid",                  :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_trab",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_efet",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_rede",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor_unid",                      :precision => 10, :scale => 3, :default => 0.0
    t.integer  "status",                                                         :default => 0,   :null => false
    t.integer  "verifica",                                                       :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", :force => true do |t|
    t.text     "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "busca_professor", :id => false, :force => true do |t|
    t.integer "matricula", :null => false
    t.string  "nome",      :null => false
    t.string  "funcao",    :null => false
  end

  create_table "configurations", :force => true do |t|
    t.integer  "user_id"
    t.date     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "begin_period"
    t.date     "end_periods"
  end

  create_table "correcaos", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "acum_trab_id"
    t.integer  "valor_ant",    :limit => 10, :precision => 10, :scale => 0
    t.integer  "valor",        :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fichas", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "acum_trab_id"
    t.integer  "trabalhado_anterior_id"
    t.integer  "trabalhado_atual_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "total_geral",                          :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "total_titulacao",                      :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "total_trabalhado",                     :precision => 10, :scale => 3, :default => 0.0
    t.integer  "ano_letivo"
    t.integer  "tot_acum_ant_trab",      :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_efet",      :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_rede",      :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_ant_unid",      :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "tot_acum_trab",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "tot_acum_efet",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "tot_acum_rede",          :limit => 10, :precision => 10, :scale => 0
    t.integer  "tot_acum_unid",          :limit => 10, :precision => 10, :scale => 0
    t.decimal  "valor_trab",                           :precision => 10, :scale => 3
    t.decimal  "valor_efet",                           :precision => 10, :scale => 3
    t.decimal  "valor_rede",                           :precision => 10, :scale => 3
    t.decimal  "valor_unid",                           :precision => 10, :scale => 3
    t.decimal  "tot_geral_trab",                       :precision => 10, :scale => 3
    t.decimal  "tot_geral_efet",                       :precision => 10, :scale => 3
    t.decimal  "tot_geral_rede",                       :precision => 10, :scale => 3
    t.decimal  "tot_geral_unid",                       :precision => 10, :scale => 3
    t.string   "entrada_concurso"
  end

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "obs"
    t.string   "data"
    t.integer  "professor_id"
    t.integer  "acumtrab_id"
    t.integer  "remocao_id"
    t.integer  "titulacao_id"
    t.integer  "regiao_id"
    t.integer  "unidade_id"
    t.integer  "trabalhado_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mensagems", :force => true do |t|
    t.integer  "user_id"
    t.string   "titulo"
    t.string   "from"
    t.string   "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "lido"
    t.integer  "para"
    t.integer  "geral",      :default => 0
  end

  create_table "professors", :force => true do |t|
    t.integer  "matricula",                                                                      :null => false
    t.string   "nome",                                                                           :null => false
    t.datetime "dt_atual"
    t.datetime "dt_ingresso"
    t.datetime "dt_nasc"
    t.string   "RG",               :limit => 20,                                :default => "0"
    t.string   "CPF",              :limit => 20,                                :default => "0"
    t.integer  "INEP",                                                          :default => 0
    t.integer  "RD",                                                            :default => 0
    t.integer  "n_filhos",                                                      :default => 0
    t.integer  "sede_id",                                                                        :null => false
    t.integer  "jornada_sem",                                                   :default => 0
    t.string   "funcao",                                                                         :null => false
    t.string   "endres"
    t.string   "complemento"
    t.string   "bairro"
    t.integer  "num"
    t.integer  "telefone"
    t.string   "cidade"
    t.string   "obs"
    t.decimal  "total_trabalhado",               :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "total_titulacao",                :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pontuacao_final",                :precision => 10, :scale => 3, :default => 0.0
    t.integer  "flag",                                                          :default => 0,   :null => false
    t.integer  "sede_id_ant"
    t.string   "log_user",         :limit => 30
    t.integer  "prioridade",                                                    :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "titulo_arrumado"
    t.string   "entrada_concurso"
  end

  create_table "professors2", :id => false, :force => true do |t|
    t.integer  "id",                                                            :default => 0,   :null => false
    t.integer  "matricula",                                                                      :null => false
    t.string   "nome",                                                                           :null => false
    t.datetime "dt_atual"
    t.datetime "dt_ingresso"
    t.datetime "dt_nasc"
    t.string   "RG",               :limit => 20,                                :default => "0"
    t.string   "CPF",              :limit => 20,                                :default => "0"
    t.integer  "INEP",                                                          :default => 0
    t.integer  "RD",                                                            :default => 0
    t.integer  "n_filhos",                                                      :default => 0
    t.integer  "sede_id",                                                                        :null => false
    t.integer  "jornada_sem",                                                   :default => 0
    t.string   "funcao",                                                                         :null => false
    t.string   "endres"
    t.string   "complemento"
    t.string   "bairro"
    t.integer  "num"
    t.integer  "telefone"
    t.string   "cidade"
    t.string   "obs"
    t.decimal  "total_trabalhado",               :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "total_titulacao",                :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "pontuacao_final",                :precision => 10, :scale => 3, :default => 0.0
    t.integer  "flag",                                                          :default => 0,   :null => false
    t.integer  "sede_id_ant"
    t.string   "log_user",         :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "titulo_arrumado"
  end

  create_table "regiaos", :force => true do |t|
    t.string   "nome",       :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "remocaos", :force => true do |t|
    t.integer  "professor_id",                                                         :default => 0,   :null => false
    t.integer  "ano_letivo",                                                           :default => 0,   :null => false
    t.integer  "remocao",                 :limit => 1,                                 :default => 0,   :null => false
    t.decimal  "valor_unid",                            :precision => 10, :scale => 3, :default => 0.0, :null => false
    t.integer  "unidade_ant",                                                          :default => 0
    t.integer  "unidade_atual",                                                        :default => 0
    t.integer  "status",                                                                                :null => false
    t.integer  "unidade_id"
    t.integer  "remocao_efetivada",       :limit => 1
    t.integer  "tot_acum_unid",           :limit => 13, :precision => 13, :scale => 0, :default => 0,   :null => false
    t.decimal  "tot_geral_unid",                        :precision => 10, :scale => 3, :default => 0.0, :null => false
    t.decimal  "total",                                 :precision => 10, :scale => 3, :default => 0.0
    t.integer  "flag_remocao_finalizada",                                              :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type_of"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "titulacaos", :force => true do |t|
    t.string   "tipo",                                                       :null => false
    t.string   "descricao",                                                  :null => false
    t.string   "referencia",                                                 :null => false
    t.decimal  "valor",      :precision => 10, :scale => 3, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titulo_professors", :force => true do |t|
    t.integer  "titulo_id",                                                          :null => false
    t.integer  "professor_id",                                                       :null => false
    t.string   "obs",                                                                :null => false
    t.integer  "quantidade",                                      :default => 0
    t.decimal  "pontuacao_titulo", :precision => 10, :scale => 3, :default => 0.0
    t.decimal  "valor",            :precision => 10, :scale => 3, :default => 0.0
    t.date     "dt_titulo"
    t.date     "dt_validade"
    t.boolean  "status",                                          :default => true
    t.integer  "validade",                                        :default => 0
    t.integer  "ano_letivo",                                      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tipo_curso",                                      :default => false
  end

  create_table "trabalhados", :force => true do |t|
    t.integer  "professor_id",                                     :null => false
    t.integer  "ano",                                              :null => false
    t.integer  "dias",                          :default => 0
    t.integer  "unidade",                       :default => 0
    t.integer  "outro_trab",                    :default => 0
    t.integer  "f_abonada",                     :default => 0
    t.integer  "atestado",                      :default => 0
    t.integer  "f_justif",                      :default => 0
    t.integer  "f_injustif",                    :default => 0
    t.integer  "lic_saude",                     :default => 0
    t.integer  "afastamento",                   :default => 0
    t.integer  "dias_trab",                     :default => 0
    t.integer  "dias_efetivos",                 :default => 0
    t.integer  "dias_rede",                     :default => 0
    t.integer  "dias_unidade",                  :default => 0
    t.boolean  "flag",                          :default => false
    t.integer  "ano_letivo"
    t.boolean  "remocao"
    t.integer  "call_back",        :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "outras_ausencias",              :default => 0
  end

  create_table "unidades", :force => true do |t|
    t.string   "nome"
    t.integer  "tipo"
    t.integer  "regiao_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.integer  "regiao_id",                               :default => 0
    t.string   "layout",                                  :default => "application"
    t.string   "password_reset_code"
  end

  create_table "visaos", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
