class Invoice < ActiveRecord::Base
  belongs_to :operator
  before_save :clear_done_date_if_undone
  
#   validates :title, presence: true
  
  #   moja kolumna valid for logic pozwala dodac kulawy ale nie pozwala go przetwarzac przed poprawieniem
  
  def self.default_instance_actions
    return ['mark_as_done', 'show', 'edit', 'destroy', 'mark_valid_due_date_true', 'mark_valid_due_date_false', 'copy_value_from_last']
  end
  
  def self.get_virtual_columns
    return ['priority', 'valid?']
    #     w sumie valid moze chce zawsze miec na wszystkich z automatu
  end
  
  def self.default_model_actions
    return [ 'filtered/done', 'filtered/not_done', 'filtered/latest', 'filtered/overdue', 'filtered/fancy', 'new']
  end
  
  def mark_as_done
    return false if self.done
    return false unless self.valid?
    return false if self.value.nil?
    return false if self.title.nil?
    NextInvoiceLogic::create_next(self)
    execute_as_done
  end
  
  def copy_value_from_last
    return false unless is_value_from_last_accesible?
    return false unless value.nil?
    last_value = get_last_invoice_before_me_value
    self.value = last_value
    self.save
    return true
  end
    
  def get_last_invoice_before_me_value
    return operator.invoices.where.not( {id:id} ).last.value
  end
  
  def mark_valid_due_date(value)
    self.valid_due_date = value
    self.save
  end

  private
    
    def execute_as_done
      self.done = true
      self.done_date = NowService::get_now
      self.save
    end

    def clear_done_date_if_undone
      self.done_date = nil unless self.done
    end
  
    def is_value_from_last_accesible?
      return false if operator.nil?
      return false if operator.invoices.count < 2
      last_invoice_value = get_last_invoice_before_me_value
      return false if last_invoice_value.nil?
      return true
    end
    
end
