class Fedora
  include HTTParty
  debug_output #stdout
  base_uri 'http://localhost:8984'
  headers 'Accept' => 'application/ld+json'
  format :json
  def self.rest
    get('/rest')
  end
end