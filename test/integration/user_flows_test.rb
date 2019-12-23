require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:two)
  end

  test "should be able to register, login and create an event" do
    get '/signup'
    assert_response :success
    post '/users', params: { locale: :en, user: { mail: 'test@mail.ru', name: 'test', password: 'secret', password_confirmation: 'secret', surname: 'test' }}
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p', 'User was successfully created.'

    get '/login'
    assert_response :success

    post '/sessions', params: { email: 'test@mail.ru', password: 'secret' }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p#notice', 'Logged in!'

    get '/events/new'
    assert_response :success
    post '/events', params: {locale: :en, event: {date: @event.date, description: @event.description, name: @event.name, address: @event.address, creator: session[:user_id], event_type: @event.event_type.id.to_s } } 
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p#notice', 'Event was successfully created.'
  end

  test "should be able to browse, but shouldn't create" do
    get '/'
    assert_response :success
    assert_select 'h1', 'Events'

    get '/events/new'
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'p#notice', 'Please sign up or login'
  end

end
