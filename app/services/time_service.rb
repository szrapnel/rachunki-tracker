class TimeService
  
  @@session=nil
  
  def self.set_session(session)
    @@session = session
  end
  
  def self.get_session
    @@session
  end

  def self.get_now
    return get_date_from_session if get_date_from_session
    return Date.today.to_date
  end
  
  def self.get_date_from_session
    return nil if @@session.nil?
    return nil if @@session['actual_date'].nil?
    return @@session['actual_date'].to_date
  end
  
end
