class Invoice < ActiveRecord::Base
  belongs_to :operator
  before_save :clear_done_date_if_undone
  
#   validates :title, presence: true
  
  def self.default_instance_actions
    return ['mark_as_done', 'show', 'edit', 'destroy', 'mark_valid_due_date_true', 'mark_valid_due_date_false']
  end
  
  def self.get_virtual_columns
    return ['priority', 'valid?']
    #     w sumie valid moze chce zawsze miec na wszystkich z automatu
  end
  
  def self.default_model_actions
    return [ 'filtered/done', 'filtered/not_done', 'filtered/latest', 'filtered/overdue', 'filtered/fancy', 'new', 'status']
  end
  
  def mark_as_done
    return false unless self.valid?
    NextInvoiceLogic::create_next(self)
    execute_as_done
  end
  
  def mark_valid_due_date(value)
    self.valid_due_date = value
    self.save
  end

  private
    
    def execute_as_done
      self.done = true
      self.done_date = DateTime.now.to_date
      self.save
    end

    def clear_done_date_if_undone
      self.done_date = nil unless self.done
    end
    
end
