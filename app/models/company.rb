class Company < ApplicationRecord
	validates_presence_of :nome_fantasia, :cnpj, :telefone, :cidade, :estado
	validates_length_of :cep, :maximum => 8
	validates_length_of :cnpj, :maximum => 14
	validates :cep, numericality: { only_integer: true }
	validates :cnpj, numericality: { only_integer: true }
	validate :cnpj_unico, on: :create

	def cnpj_unico
		x = Company.where("cnpj = '#{self.cnpj}'")	
    	errors.add(:cnpj, "já está sendo usado") if x.size > 0
	end

	before_save :maiusculo
  	def maiusculo
      self.nome_fantasia.upcase!
      self.razao_social.upcase!
      self.logradouro.upcase!     
      self.bairro.upcase!     
      self.cidade.upcase!                    
  	end	

 
end
