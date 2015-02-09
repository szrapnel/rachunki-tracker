module ActionsHelper
  
  def generate_default_model_actions(model)
    result = ''  
    default_model_actions = get_default_model_actions(model)
    default_model_actions.each do |action|
      result += prepare_static_action_link(model, action)
      result += tag('br')
    end
    return result.html_safe
  end

    #     rename
  def prepare_actions(elem) 
    action_names = get_instance_actions(elem)
    result = ''
    action_names.each do |action_name|
      result += prepare_action_link(elem, action_name)
      result += ' | '
    end
    return result.to_s.html_safe
  end

  #   move
  def get_instance_actions(object, action_names=nil)
    return action_names unless action_names.nil?
    return object.class::default_instance_actions if object.class.respond_to? :default_instance_actions
    return ['show', 'edit', 'destroy']
  end

  #   move
  def prepare_action_link(object, action_name)
    controller = "#{object.class.to_s.camelize(:lower)}s"
    controller = ignoreDecoratorStringInControllerName(controller)
    return link_to(action_name, "/#{controller}/#{object.id}") if action_name=='show'
    link_to(action_name, "/#{controller}/#{object.id}/#{action_name}")
  end
    
  def ignoreDecoratorStringInControllerName(controller)
    controller.slice! 'Decorator'
    controller
  end
    
  def prepare_static_action_link(model, action)
    controller = "#{model.to_s.camelize(:lower)}s"
    controller = ignoreDecoratorStringInControllerName(controller)
    link_to action, "/#{controller}/#{action}"
  end

  # nie wiem czy to nie powtorzenie default instance actions
  def get_default_model_actions(model)
    return model::default_model_actions if model.respond_to? :default_model_actions
    return ['new']
  end
  
  def show_additional_links(object)
    return nil if not object.class.respond_to? :additional_links
    result = ''
    object.class.additional_links.each do |link|
      result += link_to link, link
      result += ' | '
    end
    return result.html_safe
  end
  
end