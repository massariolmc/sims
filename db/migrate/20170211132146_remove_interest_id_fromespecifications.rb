class RemoveInterestIdFromespecifications < ActiveRecord::Migration[5.0]
  def change
  	remove_reference :especifications, :interest
  end
end
