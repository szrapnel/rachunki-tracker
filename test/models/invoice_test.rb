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
  
  test "done" do
    #     przeniec do helper test
    list = InvoiceHelper.done
    list.each do |item|
      assert item.done
    end
  end
  
  test "not_done" do
    #     przeniec do helper test
    list = InvoiceHelper.not_done
    list.each do |item|
      assert item.done==false
    end
  end
  
end
