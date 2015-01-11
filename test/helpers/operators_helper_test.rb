require 'test_helper'

class OperatorsHelperTest < ActiveSupport::TestCase

  test "get_abandoned_operators" do
    list = OperatorsHelper.get_abandoned_operators
    assert_equal 6, list.count
    assert_equal Operator.find(1), list.first
    assert_equal Operator.find(4), list.second
  end
  
end
