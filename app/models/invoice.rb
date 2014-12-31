class Invoice < ActiveRecord::Base
  belongs_to :operator

  def self.mark_as_done(id)
    invoice = Invoice.find(id)
    fail 'oops' if invoice.nil?
    execute_as_done(invoice)

    create_next(invoice)
  end

  def self.done
    Invoice.where(done: true)
  end

  def self.latest
    list = Operator.all.map { |o| o.invoices.last }
    list.compact

    list2 = Invoice.where(operator_id: nil)
    list2 = list2.to_a
    list2.compact
    
    list3 = list + list2
    list3.compact
#     Invoice.where(done: true)
    #     ale tak naprawde to nie last bo daty sa wazne
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

  def self.execute_as_done(invoice)
    invoice.done = true
    invoice.done_date = DateTime.now.to_date
    invoice.save
  end

  def self.create_next(invoice)
    new_invoice = Invoice.new
    new_invoice.operator = invoice.operator
    new_invoice.due_date = calculate_new_due_date(invoice)
    new_invoice.title = get_next_title(invoice.title)
    new_invoice.done = false
    new_invoice.save
  end

  def self.calculate_new_due_date(invoice)
    unless invoice.operator.nil?
      return invoice.due_date+invoice.operator.days_between_invoices.days
    end
  end

  def self.get_next_title(old_title)
    source = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    destination = ['II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII', 'I']
    return destination[source.index(old_title)];
  end

end
