class AddAutoPaymentToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :auto_payment, :boolean, default: false
  end
end
