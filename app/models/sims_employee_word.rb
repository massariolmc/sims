class SimsEmployeeWord < ApplicationRecord

	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "tb_pessoa_estserv_data"
  	self.primary_key = "pesesdid"
end
