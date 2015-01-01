class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:destroy, :edit, :update]

  def new
    @invoice = Invoice.new
  end

  def index
    @list = Invoice.all  
    @item = @list.first
    render template: "layouts/magic_view"
  end
  
  def edit
  end
  
  def update
    if @invoice.update(invoice_params)
      redirect_to invoices_path, notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end
  
  def filtered
    @list = InvoiceHelper.send(params[:filter_name])
    render template: "layouts/magic_view"
  end
  
  def mark_as_done
    Invoice::mark_as_done(params[:id])
    redirect_to invoices_path, notice: "Invoice marked successfully."
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, notice: "Invoice created successfully."
    else
      render action: 'new'
    end
  end
  
  def destroy
    @invoice.destroy
    redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
  end
  
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end
  
  def invoice_params
    params.require(:invoice).permit(:title, :value, :operator_id, :done, :done_date, :due_date)
  end

end