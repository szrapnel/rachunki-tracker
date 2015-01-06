module OperatorsHelper
  
  def self.get_abandoned_operators
    operators = Operator.all
    abandoned = []
    operators.each do |operator|
      #       a moze to fcja operatora
      abandoned.push(operator) if operator.check_if_abandoned?
    end
    return abandoned
  end
  
end
