class AddUserToInterests < ActiveRecord::Migration[5.0]
  def change
  	add_column :interests, :user_cadastro, :integer
  	add_column :interests, :user_atualiza, :integer
  end
end
