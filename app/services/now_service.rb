class NowService

  def self.get_now
    return Date.today.to_date
#     return '30-03-2014'.to_date
  end
  
end
