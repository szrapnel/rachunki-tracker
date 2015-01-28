class RenameAgainDoneToPaidColumnInInvoice < ActiveRecord::Migration
  def change
    rename_column :invoices, :done_date, :payment_date
  end
end
