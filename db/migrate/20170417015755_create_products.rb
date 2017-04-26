class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.references :loan, foreign_key: true, null: false, default: ""
      t.string :nome, null: false, default: ""
      t.text :descricao, null: false, default: ""
      t.references :appointment, foreign_key: true, null: false, default: ""
      t.integer :qtde
      t.references :situation, foreign_key: true, null: false, default: ""
      t.references :user, foreign_key: true, null: false, default: ""
      t.text :obs

      t.timestamps
    end
  end
end
