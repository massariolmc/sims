class CreateEspecifications < ActiveRecord::Migration[5.0]
  def change
    create_table :especifications do |t|
      t.text :descricao
      t.references :type, foreign_key: true
      t.integer :qtde
      t.decimal :valor_un
      t.references :interest, foreign_key: true
      t.references :modality, foreign_key: true

      t.timestamps
    end
  end
end
