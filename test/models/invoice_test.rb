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
  
end
