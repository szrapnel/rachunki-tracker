require 'test_helper'

class OperatorTest < ActiveSupport::TestCase

  test "check_if_abandoned true" do
    operator = Operator.find 1
    assert_equal operator.check_if_abandoned?, true
  end
  
  test "check_if_abandoned false" do
    operator = Operator.find 2
    assert_equal operator.check_if_abandoned?, false
  end
  
end
