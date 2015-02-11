module MyTableHelper
  
  def magic_table(collection={}, action_names=nil)
    #     moze nil tez tutaj do ifa dodaj
    return "no data in collection" if collection.empty?
    action_names = get_instance_actions(collection.first, action_names)
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
              #               TODO tutaj moze wepnij klikalny link po id
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

    #     usun default value actions_names
    def concat_actions(elem, action_names=[]) 
      action_names.each do |action_name|
        concat content_tag(:td, prepare_action_link(elem, action_name)).to_s.html_safe
      end
    end

    def get_columns_for_table(object)
      result = []
      column_names = get_column_names(object)
      # TODO czy tutaj tez virtual
      column_names.each do |cm|
        result << {:name => cm, :display_name => cm}
      end
      if object.class.respond_to? :get_virtual_columns
        column_names = object.class::get_virtual_columns
        column_names.each do |cm|
          result << {:name => cm, :display_name => cm}
        end
      end
      return result
    end
  
end