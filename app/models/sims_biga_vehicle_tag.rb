class SimsBigaVehicleTag < ApplicationRecord
	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "biga.tb_veiculo_selo"
  	self.primary_key = "vsl_id"
end
