module InvoiceHelper
  
  def self.done
    Invoice.where(done: true)
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
    list = Invoice.where(['due_date < ?', DateTime.now.to_date])
  end

  def self.fancy
#     @due_this_week = current_user.tasks.where(due_date: Date.today..1.week.from_now)

#     list = Invoice.where(due_date: Date.today..2.week.from_now)
      #       to jest spoko

    list = Invoice.where(['due_date < ?', 2.week.from_now]).where(done: false)
    list2 = Invoice.where(due_date: nil).where(done: false)
    
    list3 = list + list2

#     list = Invoice.where(['due_date < ?', DateTime.now.to_date])
  end

  def self.not_done
    Invoice.where(done: false)
  end
  
end
