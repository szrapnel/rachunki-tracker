module ViewHelper
  
  def magic_item(object)
    column_names = get_column_names(object)    
    column_names += get_virtual_column_names(object)
    result = ''
    column_names.each do |cm|
      result += " #{cm}: #{object[cm]}"
    end
    return result
  end

  def magic_show(object)
    column_names = get_column_names(object)
    column_names += get_virtual_column_names(object)
    result = content_tag(:h2, object.class)
#     result =''
    result += content_tag :table do
#       column_names.each do |cm|
        column_names.collect { |cm|
          content_tag :tr do
            concat content_tag(:td, cm).to_s.html_safe
#             if object.respond_to? cm.to_sym
#               concat content_tag(:td, object.send(cm))
#             else
#               concat content_tag(:td, object[cm]).to_s.html_safe
#             end
            
            #             TODO tutaj zamiast w smart sprawdzac czy to referencja moge lapac pola _id i usuwac id i traktowac jak zwykle pole od tetaz po prostu bedzie latiwej nawet
            concat content_tag(:td, get_smart_field_value(object, cm)).to_s.html_safe
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

  def get_field_or_virtual_field_value(object, field_name)
    a = get_field_or_virtual_field_value_normal(object, field_name)
    if a.kind_of?(Array) || a.kind_of?(ActiveRecord::Associations::CollectionProxy)
        return a.count
    else
        return a
    end
  end

  def get_field_or_virtual_field_value_normal(object, field_name)
    if object.respond_to? field_name.to_sym
      return object.send(field_name)
    else
      return object[field_name]
    end
  end

  def get_virtual_column_names(object)
    result = []
    result += object.class::get_virtual_columns if object.class.respond_to? :get_virtual_columns
    return result
  end
    
  def aa(object)
    result = ''
    result += magic_table(@item.send('seasons'))
    result += magic_table(@item.send('seasons'))
    result.html_safe
  end
    
  def show_collections(object)
    return nil if not object.class.respond_to? :collections
    result = ''
    result += '<h1>Collections begin</h1>'
    object.class.collections.each do |collection|
      result += "<h2>#{collection}</h2>"
      result += magic_table(@item.send(collection))
    end
    result += '<h1>Collections end</h1>'
    result += '<hr/>'
    result.html_safe
  end
   
  def magic_list(list)
    #     TODO koniecznie przepisz ta fjce na partial albo content_tag
    result = ''
    list.each do |item|
      result += magic_item(item)
      # TODO to nie jest magic tylko kaszana
      #       mam juz metody aby to bylo dobrze uzyj ich
#       result += link_to "Mark As Done", "/invoices/mark_as_done/#{item.id}" unless item.done
#       result += link_to "Destroy", "/invoices/destroy/#{item.id}"
#       result += link_to "Edit", "/invoices/edit/#{item.id}"
      
      result += prepare_actions(item)
      result += tag('br')
    end
    return result.html_safe
  end
   
   def get_column_names(object)
     column_names = object.class.column_names
     execute_black_list_column_names(column_names)
   end
   
  private 

    def execute_black_list_column_names(column_names)
      column_names.delete('updated_at')
      column_names.delete('created_at')
  #     column_names.delete('id')
  #     TODO list to constant or config
      return column_names
    end
    
end
