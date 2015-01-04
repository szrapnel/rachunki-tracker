require 'test_helper'

class InvoiceFilteredHelperTest < ActiveSupport::TestCase

  test "done" do
    list = InvoiceFilteredHelper.done
    list.each do |item|
      assert item.done
    end
  end
  
  test "not_done" do
    list = InvoiceFilteredHelper.not_done
    list.each do |item|
      assert item.done==false
    end
  end
  
end
