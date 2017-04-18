class AssistentAppointment < ApplicationRecord
  belongs_to :appointment

   validates_presence_of :person_id, :appointment_id

   scope :verifica_carga_pessoa, -> (query) {where ("person_id = #{query} ")}

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
end
