class AddDescriptionToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :description, :text
  end
end
