class AddDoneDefaultValueToInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :done, :boolean, default: false
  end
end
