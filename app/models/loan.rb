class Loan < ApplicationRecord

  
  belongs_to :user
  belongs_to :appointment
  has_many :products, dependent: :destroy

  validates_presence_of :person_id, :data_saida, :user_id, :appointment_id 

  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

  scope :pesquisa, -> (query) {select("loans.person_id, loans.data_saida, loans.data_devolucao, loans.appointment_id,
                loans.status2, products.nome as \"nome\", products.descricao as \"descricao\", products.qtde as \"qtde\",
                loans.obs ").
        joins ("left join appointments on (appointments.id = loans.appointment_id)
                left join products on (products.loan_id = loans.id)
                left join assistent_appointments on (appointments.id = assistent_appointments.appointment_id)
                             where #{query} ")}

  scope :lista_cautela_secao1, -> (query1,query2) {joins ("left join appointments on (appointments.id = loans.appointment_id)
  							left join assistent_appointments on (appointments.id = assistent_appointments.appointment_id)
                             where appointments.person_id  = #{query1} #{query2} ")}
  scope :lista_cautela_secao2, -> (query1,query2) {joins ("left join appointments on (appointments.id = loans.appointment_id)
  							left join assistent_appointments on (appointments.id = assistent_appointments.appointment_id)
                             where assistent_appointments.person_id = #{query1} #{query2} ")}

  has_attached_file :avatar, 
                    path:":rails_root/public/pdf/loans/:id-:basename-:style.:extension", 
                    url: "/pdf/loans/:id-:basename-:style.:extension"

  validates_attachment :avatar,                          
                        :content_type => {:content_type => %w(application/x-msdownload application/pdf application/save application/msword )}, 
                        size: {in: 0..5000.kilobytes}, 
                        :message => 'Only PDF.'
  #validates_attachment_presence :avatar, on: :update

  before_save :maiusculo
  	def maiusculo
      self.obs.upcase!                    
  	end	

  def person(var)
    if var.present?
     aux = SimsPerson.find(var)
     aux.nome_inicial
    else
      "Não cadastrado"
    end
  end

  def person_nome_completo(var)
  	if var.present?
     aux = SimsPerson.find(var)
     aux.nome_completo
    else
      "Não cadastrado"
    end
  end

  def testa(var)
  	if !var
  		"Pendente"
  	else
  		"Quitado"
  	end
  end

  def testa_status2(var)
  	if var == 1
  		"Aprovada"
  	elsif var == 2
  		"Inativada "
  	elsif var == 3
  		"Finalizada"
  	else
  		"Pendente"
  	end
  end

  def label(var)
  	if var == 3
  		"success"
  	elsif var == 2
  		"warning"	
  	else
  		"danger"
  	end
  end

  def user_to_person(var)
  	if var.present?
  		aux = User.find(var)
    	aux2 = SimsPerson.find_by("peslogin = '#{aux.username}'")
    	"#{aux2.nome_posto_grad(aux2.pespostograd)} - #{aux2.pesnguerra}"    
    else
    	"Cadastro não existe"
    end
  end
  	
end
