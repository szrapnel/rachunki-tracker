class AddValidDueDateToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :valid_due_date, :boolean
  end
end
