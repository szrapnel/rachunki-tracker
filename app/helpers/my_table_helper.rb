module MyTableHelper
  
  def magic_table(collection={}, action_names=nil)
    return "no data in collection" if collection.empty?
    action_names = get_instance_actions(collection.first, action_names)
    columns = get_columns_for_table(collection.first)
    display_standard_table(columns, collection, action_names)
  end
  
  #   move
  def get_instance_actions(object, action_names)
    return action_names unless action_names.nil?
    return object.class::default_instance_actions if object.class.respond_to? :default_instance_actions
    return ['show', 'edit', 'destroy']
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
      action_names.each do |action_name|
        concat content_tag(:td, prepare_action_link(elem, action_name)).to_s.html_safe
      end
    end
  
  #   move
    def prepare_action_link(object, action_name)
      link_to(action_name, "/invoices/#{action_name}/#{object.id}")
    end

    def get_columns_for_table(object)
      result = []
      column_names = get_column_names(object)
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