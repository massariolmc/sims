class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :nome_fantasia
      t.string :razao_social
      t.string :cnpj, limit: 14
      t.string :logradouro
      t.string :numero
      t.string :bairro
      t.string :cidade
      t.string :estado, limit:2
      t.string :telefone
      t.string :cep, limit: 8

      t.timestamps
      t.index :cnpj, unique: true
    end
  end
end
