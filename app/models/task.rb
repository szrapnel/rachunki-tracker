class Task < ActiveRecord::Base
  
  def self.default_instance_actions
    ['show', 'edit', 'destroy']
  end

  def self.get_virtual_columns
    []
  end

  def self.default_model_actions
    ['new']
  end
  
end
