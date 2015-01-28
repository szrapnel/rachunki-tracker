require 'test_helper'

class NowServiceTest < ActiveSupport::TestCase

  test "get_date_from_session" do
    TimeService.set_session nil
    assert_equal nil, TimeService::get_date_from_session
    TimeService.set_session({'actual_date'=>nil})
    assert_equal nil, TimeService::get_date_from_session
    date = '11-11-11'
    TimeService.get_session['actual_date']=date
    assert_equal date.to_date, TimeService::get_date_from_session
  end

end