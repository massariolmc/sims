class SimsBlood < ApplicationRecord
	self.abstract_class = true
  	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "tb_tipo_sangue"
  self.primary_key = "sangueid"
end
