module OperatorsHelper
  
  def self.get_abandoned_operators
    operators = Operator.all
    abandoned = []
    operators.each do |operator|
      abandoned.push(operator) if operator.check_if_abandoned?
    end
    return abandoned
  end
  
  def self.get_abandoned_operators_not_listed_in_invoices(invoices)
    ids = self.get_operator_ids(invoices)
    all_operators = self.get_abandoned_operators
    result = []
    all_operators.each do |operator|
      result << operator if ids.include?(operator.id)==false
    end
    return result
  end
  
  def self.get_operator_ids(invoices)
    result = []
    invoices.each do |invoice|
      result << invoice.operator.id unless invoice.operator.nil?
    end
    return result
  end
  
end
