json.extract! event, :id, :name, :description, :date, :certain_time, :created_at, :updated_at
json.url event_url(event, format: :json)
