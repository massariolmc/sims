class UserPolicy < ApplicationPolicy
	
	def tipo_permission_login?
      user.admin?
    end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
