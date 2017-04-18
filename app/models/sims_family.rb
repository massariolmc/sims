class SimsFamily < ApplicationRecord

	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "tb_grau_parentesco"
  	self.primary_key = "parenteid"
end
