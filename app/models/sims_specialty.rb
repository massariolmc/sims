class SimsSpecialty < ApplicationRecord
	self.abstract_class = true
  	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

	self.table_name = "tb_especialidade"
  	self.primary_key = "espid"
end
