class CreateLoans < ActiveRecord::Migration[5.0]
  def change
    create_table :loans do |t|
      t.integer :person_id
      t.text :obs
      t.datetime :data_saida
      t.datetime :data_devolucao
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
