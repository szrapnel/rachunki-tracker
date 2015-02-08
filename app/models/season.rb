class Season < ActiveRecord::Base
  belongs_to :show
  
  def name
    'season_name'
  end
  
end
