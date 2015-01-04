class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:destroy, :edit, :update, :mark_as_done]
  
  def index
    @list = Invoice.all  
    render template: "layouts/magic_view"
  end

  def new
    @invoice = Invoice.new
  end
  
  def edit
  end
  
  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to invoices_path, notice: "Invoice created successfully."
    else
      render action: 'new'
    end
  end
  
  def update
    if @invoice.update(invoice_params)
      redirect_to invoices_path, notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @invoice.destroy
    redirect_to invoices_url, notice: 'Invoice was successfully destroyed.'
  end
  
  def filtered
    @list = InvoiceFilteredHelper.send(params[:filter_name])
    render template: "layouts/magic_view"
  end
  
  def mark_as_done
    @invoice.mark_as_done
#     redirect_to invoices_path, notice: "Invoice marked successfully."
    redirect_to :back, notice: 'Invoice was successfully destroyed.'
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:title, :value, :operator_id, :done, :done_date, :due_date)
    end

end