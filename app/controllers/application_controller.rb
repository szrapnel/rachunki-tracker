class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def status
  	@invoices = InvoiceFilteredHelper.fancy
    @operators = OperatorsHelper.get_abandoned_operators
    render template: "layouts/status"
  end

end
