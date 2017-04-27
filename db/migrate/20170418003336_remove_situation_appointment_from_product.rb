class RemoveSituationAppointmentFromProduct < ActiveRecord::Migration[5.0]
  def change
  	change_column_null :products, :appointment_id, true
  	change_column_null :products, :qtde, false
  end
end
