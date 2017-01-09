json.extract! fedora_resource, :id, :name, :identifier, :path, :created_at, :updated_at
json.url fedora_resource_url(fedora_resource, format: :json)