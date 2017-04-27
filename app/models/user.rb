class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable
  
  enum role: [:normal_user, :admin, :sims, :empenho_nivel_1, :empenho_nivel_2, :sims_empenho_nivel_1, :sims_empenho_nivel_2,
              :materialcarga, :materialcarga_sims, :materialcarga_empenho_nivel_1, :materialcarga_empenho_nivel_2, :materialcarga_sims_empenho_nivel_1, 
              :materialcarga_sims_empenho_nivel_2 ]
  
  before_save :email, on: :create

  has_many :loans
  has_many :products

  def email
    self.email = self.username
  end

 def login(var)
    aux = SimsPerson.find_by("peslogin = '#{var}'")
    "#{aux.nome_posto_grad(aux.pespostograd)} - #{aux.pesnguerra}"    
  end

  def person_id(var)
  	aux = SimsPerson.find_by("peslogin = '#{var}'")  	
  	aux.pesid
  end

  def appointment_id(var)
    aux = SimsPerson.find_by("peslogin = '#{var}'")
    aux2 = Appointment.find_by("perso")
    "#{aux.nome_posto_grad(aux.pespostograd)} - #{aux.pesnguerra}"    
  end  

end
