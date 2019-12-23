require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post sessions_url, params: {email: @user.mail, password: 'secret' }
  end

  # test "should get index" do
  #   get users_url
  #   assert_response :success
  # end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: {locale: :ru, user: { mail: 'test@test.ts', name: @user.name, password: 'secret', password_confirmation: 'secret', surname: @user.surname }}
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(:en, @user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(:en, @user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(:en,@user), params: { user: { mail: @user.mail, name: @user.name, password: 'secret', password_confirmation: 'secret', surname: @user.surname } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(:en, @user.id)
    end
  end
end
