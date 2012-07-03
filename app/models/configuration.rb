class Configuration < ActiveRecord::Base
  attr_accessor :check_inicio
  belongs_to :user
  
  validates_uniqueness_of :user_id, :if => :ja_existe_config?, :message => ': Ja foi criado a configuração para este usuário. Favor edita-la'
  before_save :tera_inicio



  def tera_inicio
    if (self.check_inicio).to_i == 0
      self.begin_period = nil
      self.end_periods = nil
    end
  end

  def ja_existe_config?
    Configuration.find_all_by_user_id(self.user_id)
  end

end
