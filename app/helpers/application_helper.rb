module ApplicationHelper
  
  def magic_item(object)
    magic_view(object)
  end
  
  def get_smart_field_value(object, field_name)
    if check_if_field_is_reference(field_name)
      return get_referenced_value(object, field_name)
    else
      return object.instance_eval(field_name)
    end
  end
  
  def get_referenced_value(object, field_name)
    object.instance_eval(field_name)
    fn = field_name.remove("_id")
    #     dopisz tutaj sprawdzenie czy jest pole name ew zrobic tez title jak nie
    #     oraz sprawdzuc tez czy nie ma czegos takiego jak distply field w railsach
    if object.instance_eval(fn).nil?
      return nil
    else
      return object.instance_eval(fn).name
    end
#     return object.instance_eval(fn).name
  end
  
  def check_if_field_is_reference(field_name)
    if field_name.ends_with?('_id')
      return true
    end
    return false
  end
  
  def magic_list(list)
    #     TODO koniecznie przepisz ta fjce na partial albo content_tag
    result = ''
    list.each do |item|
      result += magic_item(item)
      # TODO to nie jest magic tylko kaszana
      result += link_to "Mark As Done", "/invoices/mark_as_done/#{item.id}" unless item.done
      result += link_to "Destroy", "/invoices/destroy/#{item.id}"
      result += link_to "Edit", "/invoices/edit/#{item.id}"
      result += tag('br')
    end
    return result.html_safe
  end
  
  private 
    def magic_view(object)
      column_names = get_column_names(object)
      result = ''
      column_names.each do |cm|
        result += " #{cm}: #{object[cm]}"
      end
      return result
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
