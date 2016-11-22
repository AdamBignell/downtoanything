json.extract! submission, :id, :score, :challenge_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)
