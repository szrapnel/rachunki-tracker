class AddDaysBetweenInvoicesToOperator < ActiveRecord::Migration
  def change
    add_column :operators, :days_between_invoices, :int
  end
end
