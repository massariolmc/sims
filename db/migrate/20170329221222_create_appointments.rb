class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer :sims_tba_esq_secao_id
      t.text :obs
      t.references :person_id
      t.integer :user_id

      t.timestamps
    end
  end
end
