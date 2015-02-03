class Operator < ActiveRecord::Base
  has_many :invoices
  
  validates :name, presence: true
  
  def self.get_virtual_columns
    return ['get_last_payment_date', 'valid?', 'logic_valid?', 'check_if_abandoned?', 'invoice_number', 'invoices_paid_decorated', 'invoices_not_paid_decorated']
  end
  
  def self.default_model_actions
    return ['new', 'abandoned']
  end

  #   TODO rename
  def check_if_abandoned?
    return false if closed
    return true if days_between_invoices.nil?
    last_payment_date = get_last_payment_date
    return true if last_payment_date == 'NEVER DONE'
    last_payment_date+days_between_invoices < TimeService::get_now
    
#       return true if invoices.empty?
    #     czy last tutaj jest bezpieczne chodzi o to ze opiera sie create albo id czy cos
#       return false if invoices.last.done_date.nil?
#     invoices.last.done_date+days_between_invoices < NowService::get_now
  end

  def logic_valid?
    days_between_invoices.present?
  end
  
  def get_last_payment_date
    paid_invoices = invoices.where.not({payment_date:nil})
    return 'NEVER DONE' if paid_invoices.empty?
    paid_invoices.order('payment_date DESC').first.payment_date
#     return 'NEVER DONE' if last_done_date.nil?
  end
  
  def invoice_number
    invoices.count
  end
  
end
