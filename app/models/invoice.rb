class Invoice < ActiveRecord::Base
  belongs_to :operator
  before_save :clear_done_date_if_undone
  
  def self.default_instance_actions
    return ['mark_as_done', 'show', 'edit', 'destroy']
  end
  
  def self.get_virtual_columns
    return ['priority']
  end
  
  def self.default_model_actions
    return [ 'filtered/done', 'filtered/not_done', 'filtered/latest', 'filtered/overdue', 'filtered/fancy', 'new']
  end
  
  #   decorator
  def priority
    return 'DONE' if self.done
    return 'OVERDUE' if self.due_date<NowService::get_now
    return 'CRITICAL' if self.due_date-3.days<NowService::get_now
    return 'URGENT' if self.due_date-7.days<NowService::get_now
    return 'COOL' if self.due_date-2.weeks<NowService::get_now
    return 'FAR AWAY' if self.due_date-3.weeks<NowService::get_now
    return 'FAR FAR AWAY'
  end
 
  def mark_as_done
    execute_as_done
    NextInvoiceLogic::create_next(self)
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
