class SimsGate < ApplicationRecord
	
	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "bulldog.tba_portoes"
  	self.primary_key = "portao_id"
end
