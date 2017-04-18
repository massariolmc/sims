class Loan < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  validates_presence_of :person_id, :data_saida, :user_id 

  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

  before_save :maiusculo
  	def maiusculo
      self.obs.upcase!                    
  	end	
end
