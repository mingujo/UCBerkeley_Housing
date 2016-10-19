json.extract! scheduler, :id, :name, :email, :login, :created_at, :updated_at
json.url scheduler_url(scheduler, format: :json)