class SimsCavVehicle < ApplicationRecord
	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  self.table_name = "cav.tb_visitante_veic"
  self.primary_key = "visveicid"

  scope :carros, -> (query) {where(" visveic_visitante = #{query}")}
end
