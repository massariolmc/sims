class SimsOrganization < ApplicationRecord
		self.abstract_class = true
    if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  self.table_name = "tb_om"
  self.primary_key = "omid"
end
