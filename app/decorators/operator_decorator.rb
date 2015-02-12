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
  
  def ok_to_show?
    if operator_postpone
      return operator_postpone.ok_to_show?
    end
    true
  end

end