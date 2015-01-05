require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

  test "mark as done" do
    invoice = Invoice.find(1)
    invoice.mark_as_done
    
    org = Invoice.find(1)
    assert org.done
    
    last = Invoice.last
    #     co z due date
    assert_equal TitleGenerator::get_next_title(org.title), last.title
    assert_equal false, last.done
    assert_equal org.operator, last.operator
  end
  
  test "mark_valid_due_date with true" do
    invoice = Invoice.find(1)
    invoice.mark_valid_due_date true
    invoice = Invoice.find(1)
    assert_equal invoice.valid_due_date, true
  end

  test "mark_valid_due_date with false" do
    invoice = Invoice.find(1)
    invoice.mark_valid_due_date false
    invoice = Invoice.find(1)
    assert_equal invoice.valid_due_date, false
  end
  
  test "clear done_date if not done" do
    invoice = Invoice.find 4
    invoice.done=false
    invoice.save
    
    invoice = Invoice.find 4
    assert_equal invoice.done_date, nil
  end
  
end
