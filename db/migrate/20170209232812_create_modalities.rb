class CreateModalities < ActiveRecord::Migration[5.0]
  def change
    create_table :modalities do |t|
      t.string :nome
      t.text :obs

      t.timestamps
    end
  end
end
