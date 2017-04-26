class SimsBigaLicense < ApplicationRecord
	  if Rails.env == 'development'
     self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  	self.table_name = "biga.tb_cnh"
  	self.primary_key = "cnh_pes_id"

  	validates_presence_of :cnh_pes_id, :cnh_pes_tipo, :cnh_numero, :cnh_validade, :cnh_cat, :cnh_uf

  	scope :cnh_vencidas, -> {select("tb_local_presta_servico.lpsdesc, 
  										tb_posto_graduacao.pgabrev || ' -  ' || tb_pessoas.pesnguerra as \"nome\", 
										tb_pessoas.pesncompleto, biga.tb_cnh.cnh_validade, tb_situacao.situacaodesc ").  									
  									joins("left join tb_pessoas on (tb_pessoas.pesid = biga.tb_cnh.cnh_pes_id)
									left join tb_cracha on (biga.tb_cnh.cnh_pes_id = tb_cracha.crachapessoa)
									left join tb_posto_graduacao on (tb_pessoas.pespostograd = tb_posto_graduacao.pgid)
									left join tb_local_presta_servico on ((tb_pessoas.peslocaltrabalho = tb_local_presta_servico.lpsid))
									left join tb_situacao on (tb_pessoas.pessituacao = tb_situacao.situacaoid)
									where biga.tb_cnh.cnh_validade < (select CURRENT_DATE) and tb_pessoas.pessituacao <> 5")}

  	def procura_pessoa(var)
  		if PostgresqlViewPerson.exists?(:id => var) 
  			aux = PostgresqlViewPerson.find_by_id(var)  			
  			if aux.crachadevolvido == '0'
  				sit = "ATIVO"
  			else vaux.crachadevolvido == '1'
  				sit = "INATIVO"
  			end

  			if aux.crachavalidade 
  				p "#{aux.ncompleto} - Tipo do crachá: #{aux.tipo} - Posto/Graduação: #{aux.resp_posto} - Nome de Guerra: #{aux.resp_nguerra}
  			 - Nº do Cracha: #{aux.pes_cracha_id} - Validade do crachá: #{aux.crachavalidade.strftime("%d/%m/%Y")} - Situação do crachá: #{sit}"
  			else
  				p "#{aux.ncompleto} - Tipo do crachá: #{aux.tipo} - Posto/Graduação: #{aux.resp_posto} - Nome de Guerra: #{aux.resp_nguerra}
  			 - Nº do Cracha: #{aux.pes_cracha_id} - Validade do crachá: #{aux.crachavalidade}" 	
  			end
  		else
  			p "Esta pessoa foi deletada."
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
end
