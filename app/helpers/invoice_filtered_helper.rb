module InvoiceFilteredHelper
  
  def self.is_filter_name_valid? filter_name
    filters = ['paid', 'latest', 'overdue', 'fancy', 'not_paid']
    return filters.include? filter_name
  end
  
  def self.paid
    Invoice.where(paid: true)
  end

  def self.latest
    #     ale tak naprawde to nie last bo daty sa wazne
    list = Operator.all.map { |o| o.invoices.last }
    list.compact

    list2 = Invoice.where(operator_id: nil)
    list2 = list2.to_a
    list2.compact
    
    list3 = list + list2
    list3.compact
  end

  def self.overdue
#     @due_this_week = current_user.tasks.where(due_date: Date.today..1.week.from_now)
    
#     list = Invoice.where(due_date: Date.today..1.week.from_now)
    list = Invoice.where(['due_date < ?', TimeService::get_now])
  end

  def self.fancy
#     @due_this_week = current_user.tasks.where(due_date: Date.today..1.week.from_now)

#     list = Invoice.where(due_date: Date.today..2.week.from_now)
      #       to jest spoko
# 2.week.from_now
    list = Invoice.where(['due_date < ?', TimeService::get_now+2.weeks]).where(paid: false)
    list2 = Invoice.where(due_date: nil).where(paid: false)
    
    list3 = list + list2

#     list = Invoice.where(['due_date < ?', NowService::get_now])
  end

  def self.not_paid
    Invoice.where(paid: false)
  end
  
end
