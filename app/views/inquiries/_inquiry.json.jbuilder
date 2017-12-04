json.extract! inquiry, :id, :from_email, :to_email, :first_name, :last_name, :phone, :comment, :created_at, :updated_at
json.url inquiry_url(inquiry, format: :json)
