class Invoice < ActiveRecord::Base
  belongs_to :operator
  before_save :clear_done_date_if_undone
  
  #   dlaczego tyle tych selfow chyba cos zle robie
  
  #   moze static
  def default_instance_actions
    return ['mark_as_done', 'show', 'edit', 'destroy']
  end
  
  def get_virtual_columns
    return ['priority']
  end
  
  def priority
    return 'DONE' if self.done
    return 'OVERDUE' if self.due_date<NowService::get_now
    return 'URGENT' if self.due_date-7.days<NowService::get_now
    return 'COOL' if self.due_date-2.weeks<NowService::get_now
    return 'FAR AWAY' if self.due_date-3.weeks<NowService::get_now
    return 'FAR FAR AWAY'
  end
  
  def self.default_model_actions
    return [ 'filtered/done', 'filtered/not_done', 'filtered/latest', 'filtered/overdue', 'filtered/fancy', 'new']
  end
 
  def self.mark_as_done(id)
    invoice = Invoice.find(id)
    #     refac
    fail 'oops' if invoice.nil?
    execute_as_done(invoice)
    create_next(invoice)
  end

  #   private
  def self.execute_as_done(invoice)
    invoice.done = true
    invoice.done_date = DateTime.now.to_date
    invoice.save
  end

  #   czy private
  def self.create_next(invoice)
    new_invoice = Invoice.new
    new_invoice.operator = invoice.operator
    new_invoice.due_date = calculate_new_due_date(invoice)
    new_invoice.title = TitleGenerator::get_next_title(invoice.title)
    new_invoice.done = false
    new_invoice.save
  end

  #   czy private
  def self.calculate_new_due_date(invoice)
    unless invalid_data_for_new_due_date?(invoice)
      return invoice.due_date+invoice.operator.days_between_invoices.days
    end
  end
  
#   private
  def self.invalid_data_for_new_due_date?(invoice)
    invoice.operator.nil? || invoice.due_date.nil? || invoice.operator.days_between_invoices.nil?
  end
  
  def clear_done_date_if_undone
    self.done_date = nil unless self.done
  end
    
end
