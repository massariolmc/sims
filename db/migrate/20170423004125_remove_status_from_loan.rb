class RemoveStatusFromLoan < ActiveRecord::Migration[5.0]
  def change
    remove_column :loans, :status, :boolean
  end
end
