class Especification < ApplicationRecord
  belongs_to :type
  belongs_to :interest, optional: :true
  belongs_to :modality

  validates_presence_of :descricao, :type_id, :qtde, :valor_un, :modality_id
  validates_numericality_of :valor_un
  validates :qtde, numericality: { only_integer: true }


  before_save :maiusculo
  	def maiusculo
      self.descricao.upcase!                    
  	end
end
