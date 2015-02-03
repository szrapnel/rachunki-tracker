class AddClosedToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :closed, :boolean, default: false
  end
end
