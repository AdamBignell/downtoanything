json.extract! team, :id, :name, :points, :members, :created_at, :updated_at
json.url team_url(team, format: :json)