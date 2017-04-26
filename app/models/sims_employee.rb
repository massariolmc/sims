class SimsEmployee < ApplicationRecord

	  if Rails.env == 'development'
     self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "tb_pessoa_estserv"
  	self.primary_key = "pesesid"

  	validates_presence_of :pesesnome, :pesesdn, :pesescinum, :pesesciorgao, :pesescpf, :pesesfilpai, :pesesfilmae, 
  							:pesesend, :pesesendnum, :pesesendbairro, :pesesendcidade, :pesesenduf, 
  							:pesesendcep, :pesesfone1, :pesestipo, :peseslocalserv

  	scope :cracha, -> (query) {select("tb_pessoa_estserv.pesesnome, 
  				tb_pessoa_estserv_data.pesespessoa, tb_pessoa_estserv_data.peseshorarios, tb_pessoa_estserv_data.pesesdatainicial, 
  				tb_pessoa_estserv_data.pesesdatafinal, tb_pessoa_estserv_data.pesessolicitante, 
  				tb_pessoa_estserv_data.pesesdobs, tb_pessoa_estserv_data.pesesduser, tb_pessoa_estserv_data.pesesesqsolic,
  				tb_cracha_estserv.crachapessoa,tb_cracha_estserv.crachanivel, tb_cracha_estserv.crachavalidade, tb_cracha_estserv.crachadevolvido, 
  				tb_cracha_estserv.crachadatacad, tb_cracha_estserv.crachauser, tb_cracha_estserv.crachatipo, tb_cracha_estserv.crachaid,
  				(CASE WHEN tb_cracha_estserv.crachadevolvido = '0' THEN 'ATIVO' 
				    WHEN tb_cracha_estserv.crachadevolvido = '1' THEN 'INATIVO' 
				    ELSE 'others' END ) as \"situation\" ").
				joins(" 
				left join tb_pessoa_estserv_data on (tb_pessoa_estserv.pesesid = tb_pessoa_estserv_data.pesespessoa)
				left join tb_cracha_estserv on (tb_pessoa_estserv_data.pesespessoa = tb_cracha_estserv.crachapessoa)
				where tb_pessoa_estserv.pesesid = (#{query})")}
	 before_save :maiusculo
	  def maiusculo
	      self.pesesnome.upcase!
	      self.pesesciorgao.upcase!     
	      self.pesesfilpai.upcase!     
	      self.pesesfilmae.upcase!     
	      self.pesesend.upcase!     
	      self.pesesendbairro.upcase!
	      self.pesesendcidade.upcase!     
	      self.pesesenduf.upcase!
	      self.peseslocalserv.upcase!
	      self.pesestipo.upcase!
	  end
	before_create :retirar_mascara 
  	before_update :retirar_mascara 
	def retirar_mascara 
    	#self.pescpf.gsub!(/(\.|\-|\/)/, "") 
    	#self.pescep.gsub!(/(\(|\)|\-)/, "") 
    	#self.pesfone1.gsub!(/(\-)/, "") 
    	#self.pesfone2.gsub!(/(\-)/, "") 
    	#self.pesfonetrab.gsub!(/(\-)/, "") 
    	self.pesescpf.gsub!(".", "").gsub!("-", "") 
    	self.pesesendcep.gsub!("-", "")     	 
    	#self.pesfone2.gsub!("(", "").gsub!(")", "").gsub!(" ", "").gsub!("-", "")
    	#self.pesfonetrab.gsub!("(", "").gsub!(")", "").gsub!(" ", "").gsub!("-", "")
    	#self.pesfone1.gsub!("(", "").gsub!(")", "").gsub!(" ", "").gsub!("-", "")
  	end  			

  	def person(var)
  		aux = SimsUser.find(var)
  		aux2 = SimsPerson.find(aux.userpessoa)
  		aux2.nome_inicial
  	end

  	def nome_local_trabalho(aux)
    	if aux != 0 && aux != nil && SimsSquad.exists?(:lpsid => aux)
    		p = SimsSquad.find(aux)
      		p.lpsdesc      		
    	else
      		p "INATIVO E PENSIONISTAS"
    	end
  	end

  	def pegar_cracha(var) #para uma única pessoa É usado na index. A consulta SQL acima é usada para o show
  		if SimsEmployeeBadge.exists?(:crachapessoa => var)
  			aux = SimsEmployeeBadge.find_by_crachapessoa(var)
  			aux.crachaid
  		else
  			p "Não possui crachá"
  		end
  	end

  def nivelacesso(var)
  	aux = SimsGate.find(var)
  	if aux.portao_nivel_acesso == 5
  		"Todas as áreas"
  	elsif aux.portao_nivel_acesso == 6
  		"Area Residencial"
  	elsif aux.portao_nivel_acesso == 12
  		"Area Administrativa e Residencial"
  	elsif aux.portao_nivel_acesso == 3
  		"Area Operacional"
  	else
  		"Area Inexistente"	
  	end
  end

end
