class AddStatus2DefaultToLoans < ActiveRecord::Migration[5.0]
  def change
  	change_column :loans, :status2, :integer, default: 0
  end
end
