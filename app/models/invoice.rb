class Invoice < ActiveRecord::Base
  belongs_to :operator
  
  def self.mark_as_done(id)
    invoice = Invoice.find(id)
    if invoice.nil? 
      raise "oops"
    end
    execute_as_done(invoice)
    
    create_next(invoice)
  end
  
  def self.done
    Invoice.where(done: true)
  end
  
  def self.latest
    list = Operator.all.map { |o| o.invoices.last }
    list.compact
#     Invoice.where(done: true)
    #     ale tak naprawde to nie last bo daty sa wazne
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
    new_invoice.title = get_next_title(invoice.title)
    new_invoice.done = false
    new_invoice.save
  end
  
  def self.get_next_title(old_title)
    # zrob array
    case old_title
      when "I"
      return "II" 
      when "II"
      return "III"
      when "III"
      return "IV"
      when "IV"
      return "V"
      when "V"
      return "VI"
      when "VI"
      return "VII"
      when "VII"
      return "VIII"
      when "VIII"
      return "IX"
      when "IX"
      return "X"
      when "X"
      return "XI"
      when "XI"
      return "XII"
      when "XII"
      return "I"
    else
      return "it was something else"
    end
  end
  
end
