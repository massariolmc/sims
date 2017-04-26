class Type < ApplicationRecord

	validates_presence_of :nome

	before_save :maiusculo
  	def maiusculo
      self.nome.upcase!                 
  	end	
end
