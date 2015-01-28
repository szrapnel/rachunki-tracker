class Operator < ActiveRecord::Base
  has_many :invoices
  
  validates :name, presence: true
  
  def self.get_virtual_columns
    return ['get_last_payment_date', 'valid?', 'logic_valid?']
  end
  
  def self.default_model_actions
    return ['new', 'abandoned']
  end
  
  def invoices_decorated
    return InvoiceDecorator.decorate_collection(invoices)
  end
  
  def invoices_paid_decorated
    return InvoiceDecorator.decorate_collection(invoices.where({paid:true}))
  end
  
  def invoices_not_paid_decorated
    return InvoiceDecorator.decorate_collection(invoices.where({paid:false}))
  end
  
  def check_if_abandoned?
    return true if days_between_invoices.nil?
    last_payment_date = get_last_payment_date
    return true if last_payment_date == 'NEVER DONE'
    return last_payment_date+days_between_invoices < TimeService::get_now
    
#       return true if invoices.empty?
    #     czy last tutaj jest bezpieczne chodzi o to ze opiera sie create albo id czy cos
#       return false if invoices.last.done_date.nil?
#     invoices.last.done_date+days_between_invoices < NowService::get_now
  end

  def logic_valid?
    return false if days_between_invoices.nil?
    true
  end
  
  def get_last_payment_date
    paid_invoices = invoices.where.not({payment_date:nil})
    return 'NEVER DONE' if paid_invoices.empty?
    last_payment_date = done_invoices.order("payment_date DESC").first.payment_date
#     return 'NEVER DONE' if last_done_date.nil?
    return last_payment_date
  end
  
end
