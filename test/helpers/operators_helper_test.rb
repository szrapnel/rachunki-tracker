require 'test_helper'

class OperatorsHelperTest < ActiveSupport::TestCase

  test "get_abandoned_operators" do
    list = OperatorsHelper.get_abandoned_operators
    assert_equal 8, list.count
  end
  
end
