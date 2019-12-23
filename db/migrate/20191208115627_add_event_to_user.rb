class AddEventToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :user
  end
end
