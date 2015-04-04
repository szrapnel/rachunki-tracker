class Operator < ActiveRecord::Base
  has_many :invoices
  has_one :operator_postpone
  
  validates :name, presence: true
  
  def self.default_instance_actions
    ['show', 'edit', 'destroy', 'postpone_operator', 'cancel_postpone_operator', 'create_me_invoice']
  end
  
  def self.get_virtual_columns
    return ['get_last_payment_date', 'valid?', 'logic_valid?', 'check_if_abandoned?', 'invoices', 'invoices_paid_decorated', 'invoices_not_paid_decorated', 'operator_postpone', 'ok_to_show?']
  end
  
  def self.default_model_actions
    return ['new', 'abandoned', 'open', 'closed']
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
    paid_invoices.order('payment_date DESC').last.payment_date
#     return 'NEVER DONE' if last_done_date.nil?
  end
  
  def invoice_number
    invoices.count
  end
  
  def create_me_invoice
    invoice = Invoice.new
    invoice.operator_id=self.id
    invoice.save
  end
  
end
