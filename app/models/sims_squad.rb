class SimsSquad < ApplicationRecord
	self.abstract_class = true
    if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  self.table_name = "tb_local_presta_servico"
  self.primary_key = "lpsid"

   def nome_squad(aux)
  	p = SimsSquad.find(aux)
  	p.lpsdesc
   end
end
