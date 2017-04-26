class SimsBigaVehicleNote < ApplicationRecord
	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 
    
  	self.table_name = "biga.tb_veiculo_obs"
  	self.primary_key = "vob_id"
end
