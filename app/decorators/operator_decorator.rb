class OperatorDecorator < Draper::Decorator
  delegate_all
  #   sprawdz te opcje decorate children itp

  def invoices_decorated
    InvoiceDecorator.decorate_collection(invoices)
  end
  
  def invoices_paid_decorated
    InvoiceDecorator.decorate_collection(invoices.where({paid:true}))
  end

  def invoices_not_paid_decorated
    InvoiceDecorator.decorate_collection(invoices.where({paid:false}))
  end
  
  def invoices_decorated_count
    invoices_decorated.count
  end
  
  def invoices_paid_decorated_count
    invoices_paid_decorated.count
  end
    
  def
    invoices_not_paid_decorated
  end

end