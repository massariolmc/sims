class Equipment < ApplicationRecord
  belongs_to :appointment
  belongs_to :account
  belongs_to :kind
  belongs_to :situation

  validates_presence_of :nomeclatura, :appointment_id, :account_id, :kind_id, :qtde, :bmp, :valor_atualizado, :situation_id, :status
  validates :qtde, numericality: { only_integer: true }
  validates_numericality_of :valor_atualizado

  enum status: [:EM_USO, :Transferido, :Descarte_do_Material]

  before_save :maiusculo
  
  	def maiusculo
      self.nomeclatura.upcase!                    
  	end    

  def person(var)
    if var.present?
     aux = SimsPerson.find(var)
     aux.nome_inicial
    else
      "Não cadastrado"
    end
  end

end
