class InvoiceDecorator < Draper::Decorator
  delegate_all

#   TEST
  def priority
    return 'DONE' if done
    return 'OVERDUE' if due_date<NowService::get_now
    return 'CRITICAL' if due_date-3.days<NowService::get_now
    return 'URGENT' if due_date-7.days<NowService::get_now
    return 'COOL' if due_date-2.weeks<NowService::get_now
    return 'FAR AWAY' if due_date-3.weeks<NowService::get_now
    return 'FAR FAR AWAY OR INVALID'
    #      a co jak nic teraz bedzie far far a powinno byc JAKIES ZUPELNIE INNE
    #     ej a tak w ogole to jakis enum powinien byc czy cos albo array
  end
  
end