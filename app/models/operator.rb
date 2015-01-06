class Operator < ActiveRecord::Base
  has_many :invoices
  
    def check_if_abandoned?
      return true if invoices.empty?
    #     czy last tutaj jest bezpieczne chodzi o to ze opiera sie create albo id czy cos
    invoices.last.done_date+days_between_invoices < NowService::get_now
  end
  
end
