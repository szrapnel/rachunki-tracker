class InvoicesController < ApplicationController

  def new
    @invoice = Invoice.new
  end

  def index
  end

  def create
    if @invoice.save
      redirect_to invoices_path, notice: "Invoice created successfully."
    else
      render action: 'new'
    end
  end

end