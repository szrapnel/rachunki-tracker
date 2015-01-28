class Invoice < ActiveRecord::Base
  belongs_to :operator
  belongs_to :bank
  before_save :clear_payment_date_if_not_paid

  def self.default_instance_actions
    ['mark_as_paid_and_create_next', 'show', 'edit', 'destroy', 'copy_previous_value']
  end

  def self.get_virtual_columns
    ['priority', 'paid_in_time?', 'valid?', 'logic_valid?']
  end

  def self.default_model_actions
    [ 'filtered/paid', 'filtered/not_paid', 'filtered/latest', 'filtered/overdue', 'filtered/last_2_weeks', 'new']
  end

  def mark_as_paid_and_create_next
    return false unless ready_to_mark_as_paid?
    NextInvoiceLogic::create_next(self)
    mark_as_paid
  end

  def ready_to_mark_as_paid?
    return false if paid
    return false unless valid?
    return false unless logic_valid?
    true
  end

  def logic_valid?
    return false if value.nil?
    return false if title.nil?
    true
  end

  def mark_due_date_as_valid(value)
    self.valid_due_date = value
    save
  end
  
  def copy_previous_value
    return false unless previous_invoice_accessible?
    return false unless value.nil?
    self.value = get_previous_invoice_value
    save
  end

  def paid_in_time
    dates_set?
    due_date > payment_date
  end

  private
    
    def mark_as_paid
      self.paid = true
      self.payment_date = TimeService::get_now
      save
    end

    def dates_set?
      due_date.nil? || payment_date.nil?
    end

    def clear_payment_date_if_not_paid
      self.payment_date = nil unless paid
    end

    def get_previous_invoice_value
      get_previous_invoice.value if previous_invoice_accessible?
    end

    def get_previous_invoice
      operator.invoices.where.not( {id:id} ).last
    end

    def previous_invoice_accessible?
      return false if operator.nil?
      return false if operator.invoices.count < 2
      true
    end

end
