class AddBankIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :bank_id, :integer
  end
end
