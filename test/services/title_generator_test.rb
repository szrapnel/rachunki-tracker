require 'test_helper'

class TitleGeneratorTest < ActiveSupport::TestCase

  test "get_next_title" do
    assert_equal(TitleGenerator::get_next_title('I'), 'II')
    assert_equal(TitleGenerator::get_next_title('XII'), 'I')
  end
  
end