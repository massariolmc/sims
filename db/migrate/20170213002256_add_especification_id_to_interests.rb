class AddEspecificationIdToInterests < ActiveRecord::Migration[5.0]
  def change
    add_reference :interests, :especification, foreign_key: true
  end
end
