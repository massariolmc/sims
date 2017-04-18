class RenamePersonIdToAppointments < ActiveRecord::Migration[5.0]
  def change
  	rename_column :appointments, :person_id_id, :person_id
  end
end
