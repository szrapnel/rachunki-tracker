module MyTableHelper
  
  def magic_table(collection={}, action_names=['show', 'destroy', 'edit'])
    if collection.count==0
      return "no data in collection"
    end
    columns = get_columns_for_table(collection.first)
    display_standard_table(columns, collection, action_names)
  end
  
  private
    def display_standard_table(columns, collection = {}, action_names)
      thead = content_tag :thead do
        content_tag :tr do
          columns.collect {|column|  concat content_tag(:th,column[:display_name])}.join().html_safe
        end
      end
     tbody = content_tag :tbody do
       collection.collect { |elem|
        content_tag :tr do
          columns.collect { |column|
  #             concat content_tag(:td, elem.attributes[column[:name]])
              concat content_tag(:td, get_smart_field_value(elem, column[:name]))
          }.to_s.html_safe
          #         stad
          concat_actions(elem, action_names)
          #         do tad
        end
        }.join().html_safe
      end
      content_tag :table, thead.concat(tbody)
    end

    def concat_actions(elem, action_names=[]) 
  #           concat content_tag(:td, 'cccc').to_s.html_safe
  #           concat content_tag(:td, link_to("Mark As Done", "/invoices/mark_as_done/#{elem.id}")).to_s.html_safe unless elem.done
  #           concat content_tag(:td, link_to("Destroy", "/invoices/destroy/#{elem.id}")).to_s.html_safe
  #           concat content_tag(:td, link_to("Edit", "/invoices/edit/#{elem.id}")).to_s.html_safe
      action_names.each do |action_name|
        concat content_tag(:td, link_to(action_name, "/invoices/#{action_name}/#{elem.id}")).to_s.html_safe
      end
    end

    def get_columns_for_table(object)
      result = []
      column_names = get_column_names(object)
      column_names.each do |cm|
        result << {:name => cm, :display_name => cm}
      end
      return result
    end
  
end