class RenameSquadFromInterest < ActiveRecord::Migration[5.0]
  def change
  	rename_column :interests, :squad_id, :sims_squad_id
  end
end
