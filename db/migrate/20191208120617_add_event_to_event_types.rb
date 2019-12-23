class AddEventToEventTypes < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :event_type
  end
end
