class FedoraResource
  include Mongoid::Document
  field :name, type: String
  field :identifier, type: String
  field :path, type: String
end
