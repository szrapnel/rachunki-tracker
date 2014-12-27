class AddDoneToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :done, :boolean
  end
end
