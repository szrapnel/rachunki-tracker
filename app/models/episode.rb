class Episode < ActiveRecord::Base
  belongs_to :season
  
  default_scope { order('number ASC') }
  
  def self.default_instance_actions
    ['create_next_episode', 'show', 'edit', 'destroy']
  end
  
  def create_next
    e = Episode.new
    e.number = number+1
    e.season = season
    e.save
  end
  
  #   TODO validacja dwa w sezonie nie moga miec numertu takiego samegi
  #   TODO i tam samo dla show season nie dwa takie same
  
  
end
