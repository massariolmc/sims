class Interest < ApplicationRecord

  belongs_to :company
  belongs_to :sims_squad
  has_many :especifications, dependent: :destroy

  validates_presence_of :n_empenho, :aplicacao, :company_id, :sims_squad_id, :data_envio, :prazo
  validates_uniqueness_of :n_empenho, on: :create
  validates :pregao, numericality: { only_integer: true }

  has_attached_file :avatar, 
                    path:":rails_root/public/pdf/interests/:id-:basename-:style.:extension", 
                    url: "/pdf/interests/:id-:basename-:style.:extension"

  validates_attachment :avatar,                          
                        :content_type => {:content_type => %w(application/x-msdownload application/pdf application/save application/msword )}, 
                        size: {in: 0..5000.kilobytes}, 
                        :message => 'Only PDF.'
  validates_attachment_presence :avatar, on: :create            

  accepts_nested_attributes_for :especifications, reject_if: :all_blank, allow_destroy: true

  before_create :salva_user_cadastra
  before_save :maiusculo
  	def maiusculo
      self.aplicacao.upcase!                    
  	end	
    def salva_user_cadastra 
      self.user_cadastro =  self.user_atualiza
    end

    def nome_squad(var)
      nome = SimsSquad.find( var)
      nome.lpsdesc
    end


  scope :pesquisa_interests, -> (query) {
                          
                          select("").
                          joins("")}  

end
