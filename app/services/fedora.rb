class Fedora
  include HTTParty
  debug_output #stdout
  base_uri 'http://localhost:8984'
  headers 'Accept' => 'application/ld+json'
  format :json
  def self.rest(relative_id)
    # get('/rest')
    # get('/rest/dev')
    # relative_id = 'rest/'
    # relative_id = 'rest/dev'
    # relative_id = 'rest/dev/ad/1c/a0/c9/ad1ca0c9-2c88-4086-9764-166cb17afbdb'
    id = base_uri + '/' + relative_id
    response = get(id)
    json_ld = response
    response.parsed_response.each do |element|
      if element["@id"] == id
        json_ld = element
      end
    end

    context = JSON.parse(HTTParty.get("https://www.w3.org/ns/ldp.jsonld"))['@context']
    context["XMLSchema"] = "http://www.w3.org/2001/XMLSchema#"
    context["repository"] = "http://fedora.info/definitions/v4/repository#"
    context["created"] = {"@id" => "repository:created", "@type" => "XMLSchema:dateTime"}
    context["exportsAs"] = {"@id" => "repository:exportsAs", "@type" => "@id"}
    context["hasParent"] = {"@id" => "repository:hasParent", "@type" => "@id"}
    context["lastModified"] = {"@id" => "repository:lastModified", "@type" => "XMLSchema:dateTime"}
    context["numberOfChildren"] = {"@id" => "repository:numberOfChildren", "@type" => "XMLSchema:long"}
    context["writable"] = {"@id" => "repository:writable", "@type" => "XMLSchema:boolean"}
    context["hasTransactionProvider"] = {"@id" => "repository:hasTransactionProvider", "@type" => "@id"}

    context["fedora-model"] = "info:fedora/fedora-system:def/model#"
    context["rdf"] = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    context["hasModel"] = {"@id" => "fedora-model:hasModel", "@type" => "rdf:type"}

    json_ld = JSON::LD::API.compact(json_ld, context)

    json_ld.each do |key, value|
      case value
        when String
          json_ld[key].sub!(base_uri + '/', '') unless json_ld[key].frozen?
        when Array
          json_ld[key].map! { |item| item.frozen? ? item : item.is_a?(String) ? item.sub!(base_uri + '/', '') : item }
      end
    end

    json_ld
  end

end