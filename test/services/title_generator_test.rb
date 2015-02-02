require 'test_helper'

class TitleGeneratorTest < ActiveSupport::TestCase

  test 'get_next_title ROMAN' do
    assert_equal(TitleGenerator::get_next_title('I'), 'II')
    assert_equal(TitleGenerator::get_next_title('XII'), 'I')
  end

  test 'get_next_title return unchanged' do
    assert_equal 'asd', TitleGenerator::get_next_title('asd')
  end
  
end