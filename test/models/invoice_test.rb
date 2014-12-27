require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase

  test "mark as done" do
    Invoice.mark_as_done(1)
    
    org = Invoice.find(1)
    assert org.done
    
    last = Invoice.last
    assert_equal "II", last.title
    assert_equal false, last.done
    
    assert_equal org.operator, last.operator
  end
  
  
  
end
