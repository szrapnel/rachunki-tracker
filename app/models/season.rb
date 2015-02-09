class Season < ActiveRecord::Base
  belongs_to :show
  has_many :episodes
  
  default_scope { order('number ASC') }
  
  def self.default_instance_actions
    ['create_next_episode', 'show', 'edit', 'destroy']
  end
  
  def self.collections
    ['episodes']
  end
  
  def self.get_virtual_columns
    return ['episodes']
  end
  
  def name
#     show.name+' S'+number if not show.nil?
    show.name+" S#{number}"
#     number
  end
  
  def create_next_episode
    return false if episodes.count==0
    last = episodes.last
    last.create_next
  end
  
end
