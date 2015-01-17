require 'test_helper'

class NowServiceTest < ActiveSupport::TestCase

  test "get_date_from_session" do
    NowService.set_session nil
    assert_equal nil, NowService::get_date_from_session
    NowService.set_session({'actual_date'=>nil})
    assert_equal nil, NowService::get_date_from_session
    date = '11-11-11'
    NowService.get_session['actual_date']=date
    assert_equal date.to_date, NowService::get_date_from_session
  end

end