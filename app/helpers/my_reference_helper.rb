module MyReferenceHelper  
  
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

end