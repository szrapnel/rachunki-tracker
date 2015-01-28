class RenameDoneToPaidColumnInInvoice < ActiveRecord::Migration
  def change
    rename_column :invoices, :done, :paid
  end
end
