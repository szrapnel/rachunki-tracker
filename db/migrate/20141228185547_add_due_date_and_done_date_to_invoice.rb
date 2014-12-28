class AddDueDateAndDoneDateToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :due_date, :date
    add_column :invoices, :done_date, :date
  end
end
