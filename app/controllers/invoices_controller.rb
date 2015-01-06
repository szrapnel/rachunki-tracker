class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:destroy, :edit, :update, :mark_as_done, :mark_valid_due_date_true, :mark_valid_due_date_false, :show]
  before_action :authenticate_user!
  
  def status
  	@invoices = InvoiceFilteredHelper.fancy
    @operators = OperatorsHelper.get_abandoned_operators
    render template: "layouts/status"
  end
  
  def index
    @list = Invoice.all.decorate
    render template: "layouts/magic_view"
  end
  
  def show
    @item=@invoice.decorate
#     @item=@invoice
    render template: "layouts/_magic_show"
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
    param = params[:filter_name]
    if InvoiceFilteredHelper.is_filter_name_valid? param
      @list = InvoiceFilteredHelper.send(param)
      @list = InvoiceDecorator.decorate_collection(@list)
      render template: "layouts/magic_view"
    else
      redirect_to :back, notice: 'Invalid filter name.'
    end
  end
  
  def mark_as_done
    @invoice.mark_as_done
#     redirect_to invoices_path, notice: "Invoice marked successfully."
    redirect_to :back, notice: 'Invoice was successfully destroyed.'
  end
  
  def mark_valid_due_date_true
    execute_mark_valid_due_date true
  end
  
  def mark_valid_due_date_false
    execute_mark_valid_due_date false
  end

  private
  
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:title, :value, :operator_id, :done, :done_date, :due_date, :valid_due_date)
    end
  
  def execute_mark_valid_due_date(value)
      @invoice.mark_valid_due_date(value)
      redirect_to :back, notice: 'Invoice was successfully marked.'
    end

end