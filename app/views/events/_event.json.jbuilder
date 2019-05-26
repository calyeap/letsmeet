json.extract! event, :id, :name, :description, :user_id, :user_type, :choices, :date, :created_at, :updated_at
json.url event_url(event, format: :json)
