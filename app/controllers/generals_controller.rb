class GeneralsController < ApplicationController
  
  def status
#     raise 'here'
  	fancy = InvoiceFilteredHelper.fancy
    #     to jest do bani bo musze pamietac o tych decoratorach zawsze - nie moze tak byc
    #     pozatym to ze tym sie zmienia tez jest zupelnie do bani
    @invoices = InvoiceDecorator.decorate_collection(fancy)
    @operators = OperatorsHelper.get_abandoned_operators
    render template: "layouts/status"
  end
  
  def set_now(now=params[:actual_date])
    if now.nil?
#       now = Date.today
    else
      unless now.class==Date.today.class
        begin
           Date.parse(now)
        rescue ArgumentError
          raise 'invalid argument exception, expected valid date string for example "10-01-2014"'
        end
      end
    end
    user_session[:actual_date] = now
    redirect_to root_path, notice: "Now set to #{user_session[:actual_date]}"
  end

  def now_plus_time_in_weeks(delta=params[:number_of_weeks])
    set_now(TimeService::get_now+delta.to_i.weeks)
  end

  def now_minus_time_in_weeks(delta=params[:number_of_weeks])
    set_now(TimeService::get_now-delta.to_i.weeks)
  end
    
  def landing_page
    if user_signed_in?
      redirect_to '/status'
    else
      redirect_to '/users/sign_in'
    end
  end

end