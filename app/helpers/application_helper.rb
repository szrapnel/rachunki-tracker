module ApplicationHelper
  
  def magic_item(object)
    magic_view(object)
  end
  
  def magic_list(list)
    result = ''
    list.each do |item|
      result += magic_item(item)
    end
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
