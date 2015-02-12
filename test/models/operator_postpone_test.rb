require 'test_helper'

class OperatorPostponeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
#   test "ok_to_show false" do
#     now = TimeService::get_now
#     puts now
#     o=OperatorPostpone.new
#     o.days = 7
#     o.save
#     puts o.created_at
#     puts now > o.created_at
#     puts o.ok_to_show?
#     o.created_at -= 21.days
#     puts o.created_at
#     puts now > o.created_at
#     puts o.ok_to_show?
#   end
  
  test 'ok_to_show created in future -> true' do
    o=OperatorPostpone.new
    o.days = 7
    o.save
    o.created_at += 7.days
    assert_equal true, o.ok_to_show?
  end
  
  test 'ok_to_show created in past -> true' do
    o=OperatorPostpone.new
    o.days = 7
    o.save
    o.created_at -= 21.days
    assert_equal true, o.ok_to_show?
  end
  
  test 'ok_to_show false' do
    o=OperatorPostpone.new
    o.days = 7
    o.save
    assert_equal false, o.ok_to_show?
  end
  
#   test 'ok_to_show true' do
#     o=OperatorPostpone.new
#     o.days = 7
#     o.save
#     o.created_at -= 14.days
#     assert_equal true, o.ok_to_show?
#   end
  
#   test 'ok_to_show true future' do
#     o=OperatorPostpone.new
#     o.days = 7
#     o.save
#     o.created_at += 14.days
#     assert_equal true, o.ok_to_show?
#   end
  
#   test "ok_to_show true" do
#     o = OperatorPostpone.new
#     o.days=7
#     o.save
#     o.created_at-=14.days
#     o.save
#     assert true, o.ok_to_show?
#   end
  
end
