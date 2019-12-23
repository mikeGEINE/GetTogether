require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
    @user = users(:one)
    post sessions_url, params: {email: @user.mail, password: 'secret' }
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { locale: :ru, event: {date: @event.date, description: @event.description, name: @event.name, address: @event.address, creator: @user.id.to_s, event_type: @event.event_type.id.to_s } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(:ru, @event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(:ru, @event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(:ru, @event), params: { event: {date: @event.date, description: @event.description, name: @event.name } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(:ru, @event)
    end

    assert_redirected_to events_url
  end

  test "should join an event" do
    assert_difference "Event.find(#{@event.id}).attendances.count", 1 do
      post join_url(:en, @event), xhr: true
    end
  end

  test "should leave an event" do
    assert_difference "Event.find(#{@event.id}).attendances.count", -1 do
      post leave_url(:en, @event), xhr: true
    end
  end

end
