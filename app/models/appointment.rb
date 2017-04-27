class Appointment < ApplicationRecord
  #belongs_to :person
  has_many :equipment
  has_many :assistent_appointment, dependent: :destroy
  belongs_to :sims_person, foreign_key: :person_id
  belongs_to :sims_department, foreign_key: :sims_tba_esq_secao_id
  has_many :loans

  validates_presence_of :person_id, :sims_tba_esq_secao_id

  #scope :verifica_carga_pessoa, -> (query) {where ("person_id = #{query} ")}
  scope :verifica_carga_pessoa, -> (query) {joins ("left join assistent_appointments on 
                                                    (appointments.id = assistent_appointments.appointment_id)
                                                    where appointments.person_id  = #{query} or assistent_appointments.person_id = #{query} ")}
  
  scope :ordena_nome_posto, -> {select (" tb_posto_graduacao.pgabrev || ' - ' || tb_pessoas.pesnguerra || ' - ' || 
                                        tba_esq_secao.esqsec_desc || ' - ' ||  tb_local_presta_servico.lpsdesc").
                      joins("inner join tb_pessoas on (tb_pessoas.pesid = appointments.person_id)
                      inner join tb_posto_graduacao on (tb_pessoas.pespostograd = tb_posto_graduacao.pgid)                      
                      inner join tb_esq_secao on (tba_esq_secao.esqsec_id = appointments.sims_tba_esq_secao_id)
                      inner join tb_local_presta_servico on (tb_local_presta_servico.lpsid = tba_esq_secao.esqsec_esq)
                      order by tb_pessoas.pespostograd asc, tb_pessoas.pesnguerra asc
                  ")}

  def person(var)
    if var.present?
  	 aux = SimsPerson.find(var)
  	 aux.nome_inicial
    else
      "Não cadastrado"
    end
  end

  def setor(var)
    if var.present?
  	 aux = SimsDepartment.find(var)
  	 aux.nome
    else
      "Não cadastrado"
    end
  end

  def appointment_nome         
      "#{person(self.person_id)} - #{setor(self.sims_tba_esq_secao_id)}"    
  end

end
