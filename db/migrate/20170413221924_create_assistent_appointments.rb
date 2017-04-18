class CreateAssistentAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :assistent_appointments do |t|
      t.integer :person_id
      t.references :appointment, foreign_key: true
      t.text :obs

      t.timestamps
    end
  end
end
