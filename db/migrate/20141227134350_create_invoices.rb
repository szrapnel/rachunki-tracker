class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.decimal :value
      t.references :operator, index: true

      t.timestamps
    end
  end
end
