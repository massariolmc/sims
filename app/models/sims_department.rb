class SimsDepartment < ApplicationRecord
		self.abstract_class = true
    
  	if Rails.env == 'development'
     self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	  self.table_name = "tba_esq_secao"
  self.primary_key = "esqsec_id"

  has_many :appointments

  validates_presence_of :esqsec_esq, :esqsec_desc, :esqsec_dficha

  before_save :maiusculo
  def maiusculo
      self.esqsec_desc.upcase!
      self.esqsec_abrev.upcase!           
  end

  def nome  	  	  	
    "#{self.esqsec_desc} - #{nome_squad(self.esqsec_esq)}"    
  end

  def ficha(aux)
  	if aux == 1
  		p "SIM"
  	else
  		p "NAO"
  	end
  end

  def nome_squad(aux)
  	p = SimsSquad.find(aux)
  	p.lpsdesc
  end
end
