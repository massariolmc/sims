class SimsPerson < ApplicationRecord

	#self.abstract_class = true
    if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 
  	
    self.table_name = "tb_pessoas"
  	self.primary_key = "pesid"

  	has_many :sims_dependents
    has_many :appointments


  EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_presence_of :pesncompleto, :pesnguerra, :pescpf, :pesidentidade, :pespostograd, :pesemail, :pescodigo, :pesdn, :pessexo, :pesend, :pesbairro, :pesnum, :pescidade, :pesuf, :pesfone1, :peslogin
  validates_uniqueness_of :pescodigo, on: :create
  validates_uniqueness_of :pescpf, on: :create
  validates_format_of :pesemail, :with => EMAIL_REGEXP
  validates :pesidentidade, numericality: { only_integer: true }, length: { maximum: 14 }
  validates :pescodigo, numericality: { only_integer: true }, length: { maximum: 7 }
  validates :pesobs, length: { maximum: 250 }
  validates :pesuf, length: { maximum: 2 }
  validates :pesnaturaluf, length: { maximum: 2 }

  scope :verifica_people, -> (query) {where ("peslogin = '#{query}' and pessituacao=4")}  
  scope :pesquisa, -> (query) { where("pesncompleto ilike ?", "%#{query}%")}
  scope :oficiais, -> { select("tb_posto_graduacao.pgabrev || ' - ' || tb_pessoas.pesnguerra as \"nome\" ").
                              joins("inner join tb_posto_graduacao on (tb_posto_graduacao.pgid = tb_pessoas.pespostograd)
                                where tb_posto_graduacao.pgrefeitorio = 1 and pessituacao=4
                                order by tb_posto_graduacao.pgid, tb_pessoas.pesnguerra")}

  before_save :maiusculo
	  def maiusculo
	      self.pesncompleto.upcase!
	      self.pesnguerra.upcase!     
	      self.pesend.upcase!     
	      self.pesbairro.upcase!     
	      self.pescidade.upcase!     
	      self.pesuf.upcase!
	      self.pesfilpai.upcase!     
	      self.pesfilmae.upcase!
	      self.pesnaturalcidade.upcase!
	      self.pesnaturaluf.upcase!
	      self.pesemail.downcase!
	  end
  before_create :retirar_mascara 
  before_update :retirar_mascara 
	def retirar_mascara 
    	#self.pescpf.gsub!(/(\.|\-|\/)/, "") 
    	#self.pescep.gsub!(/(\(|\)|\-)/, "") 
    	#self.pesfone1.gsub!(/(\-)/, "") 
    	#self.pesfone2.gsub!(/(\-)/, "") 
    	#self.pesfonetrab.gsub!(/(\-)/, "") 
    	self.pescpf.gsub!(".", "").gsub!("-", "") 
    	self.pescep.gsub!("-", "")

      if self.pesfone2.present?     	 
    	 self.pesfone2.gsub!("(", "").gsub!(")", "").gsub!(" ", "").gsub!("-", "")
      end
      if self.pesfonetrab.present?
    	 self.pesfonetrab.gsub!("(", "").gsub!(")", "").gsub!(" ", "").gsub!("-", "")
      end
      if self.pesfone1.present? 
    	 self.pesfone1.gsub!("(", "").gsub!(")", "").gsub!(" ", "").gsub!("-", "")
      end
  	end
  
  def nome_inicial  	  	  	
    "#{nome_posto_grad(self.pespostograd)} - #{self.pesnguerra}"    
  end

  def nome_completo
    "#{self.pesncompleto} - #{nome_posto_grad(self.pespostograd)}"    
  end

  def nome_posto_grad(aux)
  	p = SimsPatent.find(aux)
  	p.pgabrev
  end  

  def nome_om(aux)
    if aux != 0 && aux != nil
      p = SimsOrganization.find(aux)
      p.omdesc
    else
      p "NAO POSSUI OM"
    end
  end

  def nome_local_trabalho(aux)
    if aux != 0 && aux != nil
      p = SimsSquad.find(aux)
      p.lpsdesc
    else
      p "NAO POSSUI ESQUADRAO"
    end
  end
  
  def situacao(aux)
    p = SimsSituation.find(aux)
    p.situacaodesc
  end

  def quadro(aux)
    if aux != 0 && aux != nil
      p = SimsFrame.find(aux)
      p.quadrodesc
    else
      p "Sem cadastro"
    end
  end

  def especialidade(aux)
    if aux != 0 && aux != nil
      p = SimsSpecialty.find(aux)
      p.espdesc
    else
      p "Sem cadastro"
    end
  end

  def tipo_sangue(aux)
    if aux != 0 && aux != nil
      p = SimsBlood.find(aux)
      p.sanguesigla
    else
      p "Sem cadastro"
    end
  end

  def secao(aux)
    if aux != 0 && aux != nil
      p = SimsDepartment.find(aux)
      p.nome
    else
      p "Sem cadastro"
    end
  end

  def banco(var)
    if var.present?
  	 aux = SimsBank.find(var)
  	 "#{aux.bancocodigo} - #{aux.banconome}"
    else
      "Não possui banco cadastrado"
    end
  end

  def pegar_cracha(var) #para uma única pessoa É usado na index. A consulta SQL acima é usada para o show
      if SimsBadge.exists?(:crachapessoa => var)
        aux = SimsBadge.find_by_crachapessoa(var)
        aux.crachaid
      else
        p "Não possui crachá"
      end
  end

  def cracha_ativo(var) #para uma única pessoa É usado na index. A consulta SQL acima é usada para o show
    if SimsBadge.exists?(:crachapessoa => var)
      aux = SimsBadge.find_by_crachapessoa(var)
      aux.crachadevolvido
    else
        p "Não possui crachá"
    end
  end


end
