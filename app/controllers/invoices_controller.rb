class InvoicesController < ApplicationController

  def new
    @invoice = Invoice.new
  end

  def index
    @list = Invoices.all  
    @item = @invoices.first
    render template: "layouts/magic_view"
  end
  
  def done
    @list = Invoice.done
    render template: "layouts/magic_view"
  end
  
  def not_done
    @list = Invoice.not_done
    render template: "layouts/magic_view"
  end
  
  def mark_as_done
    Invoice::mark_as_done(params[:id])
    redirect_to invoices_path, notice: "Invoice marked successfully."
  end

  def create
    if @invoice.save
      redirect_to invoices_path, notice: "Invoice created successfully."
    else
      render action: 'new'
    end
  end

end