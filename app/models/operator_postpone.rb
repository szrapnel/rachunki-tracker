class OperatorPostpone < ActiveRecord::Base
  belongs_to :operator
  
  def ok_to_show?
    if TimeService::get_now < created_at.to_date
      return true
    else
      TimeService::get_now > (created_at.to_date + 7.days)
    end
  end
    
end
