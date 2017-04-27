class HelloController < ApplicationController
  def index
    @sims_people_active = SimsPerson.where("pessituacao = 4").count
    @sims_people_inactive = SimsPerson.where("pessituacao <> 4").count
    @sims_visitor_count = SimsCavVisitor.lista_visitantes.order("cav.tb_visitante_acesso.visacesso_datasai DESC,cav.tb_visitante_acesso.visacesso_horasai DESC,
                          cav.tb_visitante.visitante_nome ASC ")
  end

end
