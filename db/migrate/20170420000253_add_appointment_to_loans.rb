class AddAppointmentToLoans < ActiveRecord::Migration[5.0]
  def change
    add_reference :loans, :appointment, foreign_key: true
  end
end
