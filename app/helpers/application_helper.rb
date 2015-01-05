module ApplicationHelper
  
  def magic_item(object)
    column_names = get_column_names(object)
    column_names += object.class::get_virtual_columns
    result = ''
    column_names.each do |cm|
      result += " #{cm}: #{object[cm]}"
    end
    return result
  end

  def magic_show(object)
    column_names = get_column_names(object)
    column_names += object.class::get_virtual_columns
    result = content_tag(:h2, object.class)
#     result =''
    result += content_tag :table do
#       column_names.each do |cm|
        column_names.collect { |cm|
          content_tag :tr do
            concat content_tag(:td, cm).to_s.html_safe
            if object.respond_to? cm.to_sym
              concat content_tag(:td, object.send(cm))
            else
              concat content_tag(:td, object[cm]).to_s.html_safe
            end
#           result += " #{cm}: #{object[cm]}"
#           concat content_tag(:td, 'aaaa').to_s.html_safe
        end
#       end
          }.to_s.html_safe
    end
    result = result.to_s.remove('[').remove(']').remove('"').remove(', ')
#     raise result
    return result.to_s.html_safe
  end

   
  def magic_list(list)
    #     TODO koniecznie przepisz ta fjce na partial albo content_tag
    result = ''
    list.each do |item|
      result += magic_item(item)
      # TODO to nie jest magic tylko kaszana
      #       mam juz metody aby to bylo dobrze uzyj ich
      result += link_to "Mark As Done", "/invoices/mark_as_done/#{item.id}" unless item.done
      result += link_to "Destroy", "/invoices/destroy/#{item.id}"
      result += link_to "Edit", "/invoices/edit/#{item.id}"
      result += tag('br')
    end
    return result.html_safe
  end
  
  def generate_default_model_actions(model)
    result = ''  
    default_model_actions = get_default_model_actions(model)
    default_model_actions.each do |action|
      result += link_to action, "/invoices/#{action}"
      result += tag('br')
    end
    return result.html_safe
  end

  def prepare_actions(elem) 
    action_names = get_instance_actions(elem)
    result = ''
    action_names.each do |action_name|
      result += prepare_action_link(elem, action_name)
      result += ' | '
    end
    return result.to_s.html_safe
  end
  
  private 

# nie wiem czy to nie powtorzenie default instance actions
    def get_default_model_actions(model)
      return model::default_model_actions if model.respond_to? :default_model_actions
      return ['new']
    end

    def get_column_names(object)
      column_names = object.class.column_names
      execute_black_list_column_names(column_names)
    end

    def execute_black_list_column_names(column_names)
      column_names.delete('updated_at')
      column_names.delete('created_at')
  #     column_names.delete('id')
  #     TODO list to constant or config
      return column_names
    end
    
end
