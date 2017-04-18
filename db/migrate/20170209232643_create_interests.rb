class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.string :n_empenho
      t.string :aplicacao
      t.string :rsrp
      t.text :obs
      t.string :pregao
      t.references :company, foreign_key: true
      t.datetime :emissao
      t.string :processo
      t.integer :squad_id
      t.datetime :data_envio
      t.datetime :prazo

      t.timestamps
    end
  end
end
