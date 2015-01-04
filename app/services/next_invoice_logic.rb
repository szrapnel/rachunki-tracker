class NextInvoiceLogic

  def self.create_next(invoice)
    new_invoice = Invoice.new
    new_invoice.operator = invoice.operator
    new_invoice.due_date = calculate_new_due_date(invoice)
    new_invoice.title = TitleGenerator::get_next_title(invoice.title)
    new_invoice.done = false
    new_invoice.save
  end
  
  private
  
    def self.calculate_new_due_date(invoice)
      unless invalid_data_for_new_due_date?(invoice)
        return invoice.due_date+invoice.operator.days_between_invoices.days
      end
    end

    def self.invalid_data_for_new_due_date?(invoice)
      invoice.operator.nil? || invoice.due_date.nil? || invoice.operator.days_between_invoices.nil?
    end
  
end
