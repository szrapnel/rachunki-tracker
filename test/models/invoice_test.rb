require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

  test 'fix coverage' do
    fix_coverage(Invoice)
  end

#   test "mark as paid success" do
#     invoice = Invoice.find(1)
#     invoice.mark_as_paid_and_create_next
    
#     org = Invoice.find(1)
#     assert org.paid
    
#     last = Invoice.last
#     #     co z due date
#     assert_equal TitleGenerator::get_next_title(org.title), last.title
#     assert_equal false, last.paid
#     assert_equal org.operator, last.operator
#   end
  
  test "mark as paid failure" do
    invoice = Invoice.find(2)
    last_invoice = Invoice.last
    
    assert_equal false, invoice.mark_as_paid_and_create_next
    assert_equal last_invoice, Invoice.last
  end
  
  test "mark_valid_due_date with true" do
    invoice = Invoice.find(1)
    invoice.mark_due_date_as_valid true
    invoice = Invoice.find(1)
    assert_equal invoice.valid_due_date, true
  end

  test "mark_valid_due_date with false" do
    invoice = Invoice.find(1)
    invoice.mark_due_date_as_valid false
    invoice = Invoice.find(1)
    assert_equal invoice.valid_due_date, false
  end
  
  test "clear payment_date if not paid" do
    invoice = Invoice.find(4)
    invoice.paid=false
    invoice.save
    
    invoice = Invoice.find(4)
    assert_equal invoice.payment_date, nil
  end
  #----------------------------------------------------
  test "copy_value_from_last success" do
    invoice = Invoice.find(6)
    result = invoice.copy_previous_value
    assert_equal true, result
  end
  
  test "copy_value_from_last failure already has value" do
    invoice = Invoice.find(8)
    result = invoice.copy_previous_value
    assert_equal false, result
  end
  
  test "copy_value_from_last failure operator nil" do
    invoice = Invoice.find(9)
    result = invoice.copy_previous_value
    assert_equal false, result
  end
  
  test "copy_value_from_last failure last nil" do
    invoice = Invoice.find(10)
    result = invoice.copy_previous_value
    assert_equal false, result
  end
  
  test "copy_value_from_last failure last value nil too" do
    invoice = Invoice.find(12)
    result = invoice.copy_previous_value
    assert_equal true, result
  end
  
  test 'dates_set?' do
    i = Invoice.new
    result = i.send(:dates_set?)
    assert_equal false, result

    i = Invoice.new
    i.payment_date = '01-01-2015'
    result = i.send(:dates_set?)
    assert_equal false, result

    i = Invoice.new
    i.due_date = '01-01-2015'
    result = i.send(:dates_set?)
    assert_equal false, result

    i = Invoice.new
    i.payment_date = '01-01-2015'
    i.due_date = '01-01-2015'
    result = i.send(:dates_set?)
    assert_equal true, result
  end

  test 'paid_in_time?' do
    i=Invoice.new
    result = i.paid_in_time
    assert_equal false, result

    i.payment_date = '01-01-2015'
    i.due_date = '05-01-2015'
    result = i.paid_in_time
    assert_equal true, result
  end

end
