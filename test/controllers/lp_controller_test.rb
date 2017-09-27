require 'test_helper'

class LpControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lp_index_url
    assert_response :success
  end

end
