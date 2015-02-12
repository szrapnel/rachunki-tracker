class CreateOperatorPostpones < ActiveRecord::Migration
  def change
    create_table :operator_postpones do |t|
      t.integer :days
      t.integer :operator_id

      t.timestamps
    end
  end
end
