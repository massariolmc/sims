class SimsCavVisitor < ApplicationRecord
    if Rails.env == 'development'
  	 self.establish_connection :sims_development
    elsif Rails.env == 'production'
     self.establish_connection :sims_production
    end 

  self.table_name = "cav.tb_visitante"
  self.primary_key = "visitanteid"

  scope :lista_visitantes, -> {select("cav.tb_visitante.visitanteid, cav.tb_visitante.visitante_nome, cav.tb_visitante.visitante_datan, 
			cav.tb_visitante.visitante_user,
			cav.tb_visitante.visitante_telefone,
			cav.tb_visitante_acesso.visacesso_destino, cav.tb_visitante_acesso.visacesso_obs, 
			cav.tb_visitante_acesso.visacesso_cracha, cav.tb_visitante_acesso.visacesso_dataent,
			cav.tb_visitante_acesso.visacesso_horaent,cav.tb_visitante_acesso.visacesso_datasai,
			cav.tb_visitante_acesso.visacesso_horasai,cav.tb_visitante_acesso.visacesso_usersai,
			cav.tb_visitante_acesso.visacesso_userent,
			cav.tba_tipodoc_vis.tipodoc_descricao, cav.tb_visitante_doc.visdoc_docnro, 
			cav.tb_visitante_doc.visdoc_orgexp,
			cav.tba_justifica_vis.justifica_texto").
  								joins("
  				left join cav.tb_visitante_acesso on (cav.tb_visitante.visitanteid = cav.tb_visitante_acesso.visacesso_visitante)
		left join cav.tb_visitante_acomp on (cav.tb_visitante.visitanteid = cav.tb_visitante_acomp.visacomp_id)
		left join cav.tb_visitante_doc on (cav.tb_visitante.visitanteid = cav.tb_visitante_doc.visdoc_visitante)
		left join cav.tb_visitante_foto on (cav.tb_visitante.visitanteid = cav.tb_visitante_foto.visfoto_visitante)
		left join cav.tba_justifica_vis on (cav.tb_visitante.visitanteid = cav.tba_justifica_vis.justifica_vis)
		left join cav.tba_tipodoc_vis on (cav.tb_visitante_doc.visdoc_tipodoc = cav.tba_tipodoc_vis.tipodoc_id)
		where cav.tb_visitante.visitante_nome <> ''
		 ")}
	scope :lista_visitantes1, -> (query)  {select("cav.tb_visitante.visitanteid, cav.tb_visitante.visitante_nome, cav.tb_visitante.visitante_datan, 
			cav.tb_visitante.visitante_user,
			cav.tb_visitante.visitante_telefone,
			cav.tb_visitante_acesso.visacesso_destino, cav.tb_visitante_acesso.visacesso_obs, 
			cav.tb_visitante_acesso.visacesso_cracha, cav.tb_visitante_acesso.visacesso_dataent,
			cav.tb_visitante_acesso.visacesso_horaent,cav.tb_visitante_acesso.visacesso_datasai,
			cav.tb_visitante_acesso.visacesso_horasai,cav.tb_visitante_acesso.visacesso_usersai,
			cav.tb_visitante_acesso.visacesso_userent,
			cav.tba_tipodoc_vis.tipodoc_descricao, cav.tb_visitante_doc.visdoc_docnro, 
			cav.tb_visitante_doc.visdoc_orgexp,
			cav.tba_justifica_vis.justifica_texto").
  								joins("
  				left join cav.tb_visitante_acesso on (cav.tb_visitante.visitanteid = cav.tb_visitante_acesso.visacesso_visitante)
		left join cav.tb_visitante_acomp on (cav.tb_visitante.visitanteid = cav.tb_visitante_acomp.visacomp_id)
		left join cav.tb_visitante_doc on (cav.tb_visitante.visitanteid = cav.tb_visitante_doc.visdoc_visitante)
		left join cav.tb_visitante_foto on (cav.tb_visitante.visitanteid = cav.tb_visitante_foto.visfoto_visitante)
		left join cav.tba_justifica_vis on (cav.tb_visitante.visitanteid = cav.tba_justifica_vis.justifica_vis)
		left join cav.tba_tipodoc_vis on (cav.tb_visitante_doc.visdoc_tipodoc = cav.tba_tipodoc_vis.tipodoc_id)
		where cav.tb_visitante.visitante_nome ilike '%#{query}%'
		 ")} 	  


	scope :visitante, -> (query){select("cav.tb_visitante.visitanteid, cav.tb_visitante.visitante_nome, cav.tb_visitante.visitante_datan, 
			cav.tb_visitante.visitante_user,
			cav.tb_visitante.visitante_telefone,
			cav.tb_visitante_acesso.visacesso_destino, cav.tb_visitante_acesso.visacesso_obs, 
			cav.tb_visitante_acesso.visacesso_cracha, cav.tb_visitante_acesso.visacesso_dataent,
			cav.tb_visitante_acesso.visacesso_horaent,cav.tb_visitante_acesso.visacesso_datasai,
			cav.tb_visitante_acesso.visacesso_horasai,cav.tb_visitante_acesso.visacesso_usersai,
			cav.tb_visitante_acesso.visacesso_userent,
			cav.tba_tipodoc_vis.tipodoc_descricao, cav.tb_visitante_doc.visdoc_docnro,
			cav.tb_visitante_veic.visveic_tipo, cav.tb_visitante_veic.visveic_marca, cav.tb_visitante_veic.visveic_cor, cav.tb_visitante_veic.visveic_placa,
			cav.tb_visitante_veic.visveic_obs, cav.tb_visitante_veic.visveic_ano, cav.tb_visitante_veic.visveic_renavam, 
			cav.tb_visitante_doc.visdoc_orgexp,
			cav.tba_justifica_vis.justifica_texto").
  								joins("
  				left join cav.tb_visitante_acesso on (cav.tb_visitante.visitanteid = cav.tb_visitante_acesso.visacesso_visitante)
left join cav.tb_visitante_acomp on (cav.tb_visitante.visitanteid = cav.tb_visitante_acomp.visacomp_id)
left join cav.tb_visitante_doc on (cav.tb_visitante.visitanteid = cav.tb_visitante_doc.visdoc_visitante)
left join cav.tb_visitante_foto on (cav.tb_visitante.visitanteid = cav.tb_visitante_foto.visfoto_visitante)
left join cav.tb_visitante_veic on (cav.tb_visitante.visitanteid = cav.tb_visitante_veic.visveic_visitante)
left join cav.tba_justifica_vis on (cav.tb_visitante.visitanteid = cav.tba_justifica_vis.justifica_vis)
left join cav.tba_tipodoc_vis on (cav.tb_visitante_doc.visdoc_tipodoc = cav.tba_tipodoc_vis.tipodoc_id)
where cav.tb_visitante.visitanteid = #{query} 
		 ")}  

  	def cav_visitor_user(var)
  		if SimsUser.exists?(:userid => var)
  			aux = SimsUser.find(var)
  			aux2 = SimsPerson.find(aux.userpessoa)
  			aux2.nome_inicial
  		else
  			"NÃO EXISTE"
  		end
  	end
end
