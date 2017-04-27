class SimsBigaVehiclePerson < ApplicationRecord
	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "biga.tb_veiculo_pessoa"
  	self.primary_key = "vcp_id"


end
