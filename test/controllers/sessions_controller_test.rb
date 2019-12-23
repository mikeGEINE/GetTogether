require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should log in" do
    post sessions_url, params: {email: @user.mail, password: 'secret' }
    assert_equal session[:user_id], @user.id
  end
  
  test "should log out" do
    get logout_path
    assert_nil session[:user_id]
  end

end
