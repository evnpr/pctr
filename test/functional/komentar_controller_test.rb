require 'test_helper'

class KomentarControllerTest < ActionController::TestCase
  test "should get postkomentar" do
    get :postkomentar
    assert_response :success
  end

  test "should get vote" do
    get :vote
    assert_response :success
  end

end
