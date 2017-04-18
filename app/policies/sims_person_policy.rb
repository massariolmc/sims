class SimsPersonPolicy < ApplicationPolicy

	 def index?
  		user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2?
  	end
  	def index_desligados?
  		user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2?
  	end
  	def new?
  		user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2?
  	end
  	def create?
  		user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2?  		
  	end
  	def edit?
  		user.normal_user? || user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2? || user.empenho_nivel_1? || user.empenho_nivel_2?
  	end
  	def destroy?
  		user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2?
  	end
  	def update?
  		user.normal_user? || user.admin? || user.sims? || user.sims_empenho_nivel_1? || user.sims_empenho_nivel_2? || user.empenho_nivel_1? || user.empenho_nivel_2?
  	end

  	

  class Scope < Scope
    def resolve
      scope
    end
  end
end
