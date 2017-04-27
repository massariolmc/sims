class RemoveAppointmentIdFromProduct < ActiveRecord::Migration[5.0]
  def change
  	remove_column :products, :appointment_id
  end
end
