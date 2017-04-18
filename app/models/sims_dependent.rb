class SimsDependent < ApplicationRecord

	  if Rails.env == 'development'
     self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "tb_pessoas_dep"
  	self.primary_key = "pesdepid"

  	validates_presence_of :pesdepnome, :pesdepgrau, :pesdepsexo, :pesdepdn

  	belongs_to :sims_person, :foreign_key => 'pesdeppesid'

    scope :cracha, -> (query) {select("tb_pessoas.pesncompleto, tb_pessoas.pesnguerra, tb_pessoas.pes_cracha_id, 
              tb_pessoas.pes_cracha_val, tb_pessoas.peslocaltrabalho,
              tb_pessoas_dep.pesdepnome, tb_pessoas_dep.pesdepdn, tb_pessoas_dep.pes_cracha_val, tb_pessoas_dep.pes_cracha_id,
            tb_cracha.crachapessoa,tb_cracha.crachanivel, tb_cracha.crachavalidade, tb_cracha.crachadevolvido, 
            tb_cracha.crachadatacad, tb_cracha.crachauser, tb_cracha.crachatipo, tb_cracha.crachaid,
            (CASE WHEN tb_cracha.crachadevolvido = '0' THEN 'ATIVO' 
            WHEN tb_cracha.crachadevolvido = '1' THEN 'INATIVO' 
            ELSE 'others' END ) as \"situation\" ").
        joins(" 
        right join tb_pessoas on (tb_pessoas.pesid = tb_pessoas_dep.pesdeppesid)
        left join tb_cracha on (tb_pessoas_dep.pesdepid = tb_cracha.crachapessoa)
        where tb_pessoas_dep.pesdepid = (#{query})")}

  	  before_save :maiusculo
	  def maiusculo
	      self.pesdepnome.upcase!
	  end

	def family(var)
		if var != 0
  			aux = SimsFamily.find(var)
  			"#{aux.parentedesc}"
  		else
  			p "Não cadastrado"
  		end	
  	end

  	def sims_person_id(var)
  		if SimsPerson.exists?(:pesid => var) 
  			aux = SimsPerson.find(var)
  			p "#{aux.nome_posto_grad(aux.pespostograd)} - #{aux.pesnguerra} - #{aux.nome_local_trabalho(aux.peslocaltrabalho)}"
  		else
  			p "O militar titular foi deletado ou não existe."
  		end
  	end

    def situacao_person(var)
      if SimsPerson.exists?(:pesid => var) 
        aux = SimsPerson.find(var)
        p "#{aux.situacao(aux.pessituacao)}"
      else
        p "O militar titular foi deletado ou não existe."
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
