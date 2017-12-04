json.extract! review, :id, :comment, :rating, :created_at, :updated_at
json.url review_url(review, format: :json)
