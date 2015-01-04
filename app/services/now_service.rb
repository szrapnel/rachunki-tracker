class NowService
  
  @@now = Date.today.to_date
  
  def self.get_now
    return @@now
  end
  
  def self.set_now(new_now)
    @@now = new_now
  end
  
end
