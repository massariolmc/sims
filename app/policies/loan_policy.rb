class LoanPolicy < ApplicationPolicy
	def index?
      user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
      user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
    end

	 def new?
  		user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
  		user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
  	end


   def show?
      user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
      user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
    end

  	def create?
  		user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
  		user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
  	end
  	def edit?
  		user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
  		user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
  	end
  	def destroy?
  		user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
  		user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
  	end
    def update?
      user.admin? || user.materialcarga? || user.materialcarga_sims? || user.materialcarga_empenho_nivel_1? || 
  		user.materialcarga_empenho_nivel_2? || user.materialcarga_sims_empenho_nivel_1? || user.materialcarga_sims_empenho_nivel_2?
    end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
