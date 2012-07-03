class RolesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :roles

  def ativar_usuario(id)
    @ativar = User.find_by_id(id)
    @ativar.activated_at = Time.now
    @ativar.save
  end
end
