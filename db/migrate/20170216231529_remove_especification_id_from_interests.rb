class RemoveEspecificationIdFromInterests < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :interests, :especification
  end
end
