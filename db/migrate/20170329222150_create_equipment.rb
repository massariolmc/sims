class CreateEquipment < ActiveRecord::Migration[5.0]
  def change
    create_table :equipment do |t|
      t.text :nomeclatura
      t.string :sigla
      t.references :appointment, foreign_key: true
      t.references :account, foreign_key: true
      t.references :kind, foreign_key: true
      t.integer :qtde
      t.string :bmp
      t.string :n_serie
      t.string :n_pn
      t.decimal :valor_atualizado
      t.references :situation, foreign_key: true
      t.integer :status, default: 0
      t.text :obs
      t.integer :user_id

      t.timestamps
    end
  end
end
