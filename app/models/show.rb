class Show < ActiveRecord::Base
  has_many :seasons
   
  def self.collections
    ['seasons', 'fake_collection']
  end
  
  def self.get_virtual_columns
    return ['seasons']
  end
  
  def self.default_model_actions
    ['new']
  end
  
#   EJ OD TEGO ZROBILEM ELEMENT Z SUBMENU
  def self.additional_links
    return ['/shows', '/seasons', '/episodes']
  end
  
  def name
    title
  end
  
  def fake_collection
    Episode.all
  end
  
#   przemysl czym ten podprojekt rozni sie od reszty i dlaczego nagle chciales zrobic linki
  
#   czy linki sa potrzebne czy wystarczy submenu
  
#   czy te rzeczy sa jakies zagniezdzone
  
  
  
end
