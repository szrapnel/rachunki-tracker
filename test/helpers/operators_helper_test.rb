require 'test_helper'

class OperatorsHelperTest < ActiveSupport::TestCase

  test "get_abandoned_operators" do
    list = OperatorsHelper.get_abandoned_operators
    assert_equal list.count, 1
    assert_equal list.first, Operator.find(1)
  end
  
end
