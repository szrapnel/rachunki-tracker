require 'test_helper'

class OperatorTest < ActiveSupport::TestCase

  test "check_if_abandoned true" do
    #     ma dwa stare
    operator = Operator.find 1
    assert_equal operator.check_if_abandoned?, true
  end
  
  test "check_if_abandoned false" do
    #     ma jeden prawie nowy
    #     ej ten test padnie po czasie bo jest od today
    operator = Operator.find 2
    assert_equal operator.check_if_abandoned?, false
  end
  
  test "check_if_abandoned empty invoices true" do
    operator = Operator.find 4
    assert_equal operator.check_if_abandoned?, true
  end
  
end
