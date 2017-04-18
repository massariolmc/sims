class CreateTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :types do |t|
      t.string :nome
      t.text :obs

      t.timestamps
    end
  end
end
