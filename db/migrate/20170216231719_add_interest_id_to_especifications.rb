class AddInterestIdToEspecifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :especifications, :interest, foreign_key: true
  end
end
