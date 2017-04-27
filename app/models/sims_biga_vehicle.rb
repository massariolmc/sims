class SimsBigaVehicle < ApplicationRecord
	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "biga.tb_veiculo"
  	self.primary_key = "vcl_id"
end
