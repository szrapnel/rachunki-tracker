require 'test_helper'

class OperatorTest < ActiveSupport::TestCase

  test 'fix coverage' do
    fix_coverage(Operator)
  end

#   test "check_if_abandoned true" do
    #     ma dwa stare
#     operator = Operator.find(1)
#     assert_equal true, operator.check_if_abandoned?
#   end
  
  test "check_if_abandoned false" do
    #     ma jeden prawie nowy
    #     ej ten test padnie po czasie bo jest od today
    operator = Operator.find(2)
    assert_equal false, operator.check_if_abandoned?
  end
  
  test "check_if_abandoned empty invoices true" do
    operator = Operator.find(4)
    assert_equal true, operator.check_if_abandoned?
  end
  
  test "get_last_payment_date valid date" do
    operator = Operator.find(1)
    assert_equal 'Thu, 05 Jan 2012'.to_date, operator.get_last_payment_date
  end
  
  test "get_last_payment_date valid NEVER DONE" do
    operator = Operator.find(8)
    assert_equal 'NEVER DONE', operator.get_last_payment_date
  end

  test "logic_valid? false" do
    operator = Operator.find(9)
    assert_equal false, operator.logic_valid?
  end

  test "logic_valid? true" do
    operator = Operator.find(8)
    assert_equal true, operator.logic_valid?
  end

end
