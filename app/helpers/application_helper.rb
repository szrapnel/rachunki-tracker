module ApplicationHelper
  
  def magic_item(object)
    column_names = get_column_names(object)
    result = ''
    column_names.each do |cm|
      result += " #{cm}: #{object[cm]}"
    end
    return result
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
  
  def generate_default_model_global_actions(model)
    result = ''
    model::default_model_actions.each do |action|
      result += link_to action, "/invoices/#{action}"
      result += tag('br')
    end
    return result.html_safe
  end
  
  private 

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
