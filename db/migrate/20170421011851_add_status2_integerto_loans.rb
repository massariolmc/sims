class AddStatus2IntegertoLoans < ActiveRecord::Migration[5.0]
  def change
  	add_column :loans, :status2, :integer
  end
end
