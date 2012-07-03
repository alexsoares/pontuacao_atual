class Log < ActiveRecord::Base
  belongs_to :user
  belongs_to :professor

  def verifica_existe
    if !(professor_id).nil? && (regiao_id).nil? && (unidade_id).nil? && (titulacao_id).nil?
      @professor = Professor.find(:all, :conditions => ["id = ?",professor_id])
      if ((professor_id).nil? or (@professor.empty?))
        return "Não foi possivel determinar nada"
      else
        @apagado = Log.find_all_by_professor_id(professor_id)
        nao_existe_mais = 0
        for apagado in @apagado
          if apagado.obs == "Apagado"
            nao_existe_mais = nao_existe_mais + 1
          end
        end
        if obs == "Apagado" or nao_existe_mais != 0
          return professor_id.to_s + "- Com a exclusão do registro, impossível recuperar nome."
        else
          return professor_id.to_s + " " + Professor.find_by_id(professor_id).nome
        end
      end
    else
        if (professor_id).nil? && !(regiao_id).nil? && (unidade_id).nil? && (titulacao_id).nil?
          if (regiao_id).nil?
            return "Não foi possivel determinar nada"
          else
            if obs == "Apagado"
              return regiao_id.to_s + "- Com a exclusão do registro, impossível recuperar nome."
            else
              return regiao_id.to_s + " " + Regiao.find_by_id(regiao_id).nome
            end
          end
        else
          if (professor_id).nil? && (regiao_id).nil? && !(unidade_id).nil? && (titulacao_id).nil?
            if (unidade_id).nil?
              return "Não foi possivel determinar nada"
            else
              if obs == "Apagado"
                return unidade_id.to_s + "- Com a exclusão do registro, impossível recuperar nome."
              else
                return unidade_id.to_s + " " + Unidade.find_by_id(unidade_id).nome
              end
            end
          else
            if (professor_id).nil? && (regiao_id).nil? && (unidade_id).nil? && !(titulacao_id).nil?
              if (titulacao_id).nil?
                return "Não foi possivel determinar nada"
              else
                if obs == "Apagado"
                  return titulacao_id.to_s + " - Com a exclusão do registro, impossível recuperar nome."
                else
                  return titulacao_id.to_s + " - " + Titulacao.find_by_id(titulacao_id).descricao
                end
              end
            end
          end
        end
    end
  end


  def area_afetada
    
    
      if professor_id and !acumtrab_id.nil?
        return "Valores acumulados"
      else
        if professor_id and !remocao_id.nil?
          return "Remoção do professor"
        else
          if !professor_id and !titulacao_id.nil?
            return "Tabela de Titulos"
          else
            if !professor_id and !regiao_id.nil?
              $ttt = ((Regiao.find_by_id(regiao_id))).nil?
              if !($ttt)
                return "Tabela de Regiões #{Regiao.find(regiao_id)}"
              else
                return "Tabela de Regiões"
              end
            else
              if !professor_id and !unidade_id.nil?
                return "Tabela de Unidades"
              else
                if !professor_id and !trabalhado_id.nil?
                  return "Tabela de Tempo de serviço"
                else
                  if professor_id
                    @nomep = Professor.find_by_id(professor_id)
                    if !(@nomep.nil?)
                      return @nomep.nome
                    else
                      return "Tabela Professor"
                    end
                  else
                    return "Registro Apagado"
                  end
                end
              end
            end
          end
        end
      end
    
  end

  def nome_user
    return User.find(user_id).nome
  end



  def log(user,professor,action)
    self.data = (Time.now().strftime("%d/%m/%y %H:%M")).to_s
    self.professor_id = professor
    self.obs = action
    self.user_id = user
    self.save
  end
end
