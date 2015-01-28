require 'test_helper'

class InvoiceFilteredHelperTest < ActiveSupport::TestCase

  test "done" do
    list = InvoiceFilteredHelper.paid
    list.each do |item|
      assert item.paid
    end
  end
  
  test "not_done" do
    list = InvoiceFilteredHelper.not_paid
    list.each do |item|
      assert item.paid==false
    end
  end
  
end
