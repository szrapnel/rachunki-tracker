class Invoice < ActiveRecord::Base
  belongs_to :operator
  belongs_to :bank
  before_save :clear_payment_date_if_not_paid
  
#   default_scope :order => 'due_date DESC, title'
#   default_scope :order => 'due_date DESC'
  default_scope { order('due_date ASC') } 

  def self.default_instance_actions
    ['mark_as_paid_and_create_next', 'show', 'edit', 'destroy', 'copy_previous_value']
  end

  def self.get_virtual_columns
    ['priority', 'paid_in_time?', 'valid?', 'logic_valid?', 'paid_data_ok']
  end

  def self.default_model_actions
    [ 'filtered/paid', 'filtered/not_paid', 'filtered/latest', 'filtered/overdue', 'filtered/last_2_weeks','filtered/fancy', 'new']
  end

  # think about what should be executed in transactions

  # byla jeszcze uwaga ze od odczytania to potem zrobienia czegos odczytana wartosc sie moze zmienic np w mark_as_paid_and_create_next, ale moim zdaniem w copy_previus_value jest podobnie

  def mark_as_paid_and_create_next
    unless ready_to_mark_as_paid?
      return false
    end
    # TODO when mark_as_paid fails next is already created
    NextInvoiceLogic::create_next(self)
    mark_as_paid
  end

  def ready_to_mark_as_paid?
    not paid && logic_valid?
  end

  def logic_valid?
    value.present? && title.present? && operator.present?
  end
  
  def paid_data_ok
    return nil if not paid
#     bank.present? && operator.present? && due_date.present? && valid_due_date.present? && payment_date.present?
#     [bank, operator, due_date, valid_due_date, payment_date].each do |field|
#       return false if field.nil?
#     end
    [bank, operator, due_date, valid_due_date, payment_date].each {|field| return false if field.nil? }
    true
  end

  def mark_due_date_as_valid(value)
    self.valid_due_date = value
    save
  end
  
  def copy_previous_value
    return false unless previous_invoice_accessible? && value.nil?
    self.value = get_previous_invoice_value
    save
  end

  def paid_in_time
    # zobacz ze wychodzi nieprawdziwie na coverage
    # return due_date > payment_date if dates_set?
    if dates_set?
      return due_date > payment_date
    end
    false
  end
  
  private
    
    def mark_as_paid
      self.paid = true
      self.payment_date = TimeService::get_now
      save
    end

    def dates_set?
      due_date.present? && payment_date.present?
    end

    def clear_payment_date_if_not_paid
      self.payment_date = nil unless paid
    end

    def get_previous_invoice_value
      get_previous_invoice.value if previous_invoice_accessible?
    end

    def get_previous_invoice
      # nie wiesz na pewno czy ten last to jest logicznie ten last ktorego bys chcial
      operator.invoices.where.not( {id:id} ).last
    end

    def previous_invoice_accessible?
      return false if operator.nil? || operator.invoices.count < 2
      true
    end

end
