class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :nome
      t.string :sigla
      t.text :obs

      t.timestamps
    end
  end
end
