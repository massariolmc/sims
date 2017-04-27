class Product < ApplicationRecord
  belongs_to :loan, optional: :true
  belongs_to :situation
  belongs_to :user


  validates_presence_of :nome, :descricao, :qtde, :situation_id, :user_id
  validates :qtde, numericality: { only_integer: true }


  before_save :maiusculo
  	def maiusculo
      self.nome.upcase!                    
  	end	
end
