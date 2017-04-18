class CreateSituations < ActiveRecord::Migration[5.0]
  def change
    create_table :situations do |t|
      t.string :nome
      t.string :legenda
      t.text :obs

      t.timestamps
    end
  end
end
