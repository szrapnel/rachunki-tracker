class Operator < ActiveRecord::Base
  has_many :invoices
  
  def self.get_virtual_columns
    return ['get_last_done_date']
  end
  
  def check_if_abandoned?
    
    last_done_date = get_last_done_date
    return true if last_done_date.nil?
    return last_done_date+days_between_invoices < NowService::get_now
    
      return true if invoices.empty?
    #     czy last tutaj jest bezpieczne chodzi o to ze opiera sie create albo id czy cos
      return false if invoices.last.done_date.nil?
    invoices.last.done_date+days_between_invoices < NowService::get_now
  end
  
  def get_last_done_date
    return nil if invoices.empty?
    return nil if invoices.last.done_date.nil?
    return invoices.last.done_date
  end
  
end
