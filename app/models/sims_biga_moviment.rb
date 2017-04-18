class SimsBigaMoviment < ApplicationRecord
	  if Rails.env == 'development'
     self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  self.table_name = "public.v_pessoas_movimentacoes"
  #self.primary_key = "mov_id"

  scope :pesquisa, -> (query) {where("#{query}")}

  def user_gate(var)
  		if SimsPerson.exists?(:pesid => var)
  			aux = SimsPerson.find(var)  			
  			aux.nome_inicial
  		else
  			"NÃO EXISTE"
  		end
  end
 
end

