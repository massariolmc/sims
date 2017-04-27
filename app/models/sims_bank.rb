class SimsBank < ApplicationRecord

		#self.abstract_class = true
  	if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 
  	self.table_name = "tb_bancos"
  	self.primary_key = "bancoid"

  def nome_banco
    "#{self.bancocodigo} - #{self.banconome}"    
  end

end
