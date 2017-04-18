class ModalityPolicy < ApplicationPolicy

  	def new?
  		user.admin? || user.empenho_nivel_2? || user.sims_empenho_nivel_2?
  	end
  	def create?
  		user.admin? || user.empenho_nivel_2? || user.sims_empenho_nivel_2?
  	end
  	def edit?
  		user.admin? || user.empenho_nivel_2? || user.sims_empenho_nivel_2?
  	end
  	def destroy?
  		user.admin? || user.empenho_nivel_2? || user.sims_empenho_nivel_2?
  	end
    def update?
      user.admin? || user.empenho_nivel_2? || user.sims_empenho_nivel_2?
    end
  	
  class Scope < Scope
    def resolve
      scope
    end
  end
end
