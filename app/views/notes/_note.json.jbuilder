json.extract! comment, :id, :comment_by, :note, :created_at, :updated_at
json.url comment_url(comment, format: :json)
