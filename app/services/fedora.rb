class Fedora
  include HTTParty
  debug_output #stdout
  base_uri 'http://localhost:8984'
  headers 'Accept' => 'application/ld+json'
  format :json

  def self.rest(relative_id)
    id = base_uri + '/' + relative_id
    response = get(id, timeout: 600)
    json_ld = {}
    json_ld["@id"] = id
    json_ld["@type"] = ["http://www.gkostin.com/ns/HTTParty#Response"]
    # json_ld["http://www.gkostin.com/ns/HTTParty#Response:request"] = [{"@type"=>"http://www.w3.org/2001/XMLSchema#string", "@value"=>"#{response.request}"}]
    # json_ld["http://www.gkostin.com/ns/HTTParty#Response:response"] = [{"@type"=>"http://www.w3.org/2001/XMLSchema#string", "@value"=>"#{response.response}"}]
    json_ld["http://www.gkostin.com/ns/HTTParty#Response:code"] = [{"@type"=>"http://www.w3.org/2001/XMLSchema#long", "@value"=>"#{response.code}"}]
    # json_ld["http://www.gkostin.com/ns/HTTParty#Response:headers"] = [{"@type"=>"http://www.w3.org/2001/XMLSchema#string", "@value"=>"#{response.headers}"}]
    json_ld["http://www.gkostin.com/ns/HTTParty#Response:body"] = [{"@type"=>"http://www.w3.org/2001/XMLSchema#string", "@value"=>"#{response.body}"}]
    case response.code
      when 400
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#BadRequest"]
      when 404
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#NotFound"]
      when 405
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#MethodNotAllowed"]
      when 406
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#NotAcceptable"]
      when 409
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#Conflict"]
      when 410
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#Gone"]
      when 412
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#PreconditionFailed"]
      when 415
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError", "http://www.w3.org/ns/ldp#UnsupportedMediaType"]
      when 500
        json_ld["@type"] = ["http://www.w3.org/ns/ldp#RequestError"]
      when 200
        response.parsed_response.each do |element|
          if element["@id"] == id
            json_ld = element
          end
        end
      else
        # default
    end

    context = JSON.parse(%({
      "@context" : {
        "id" : "@id",
        "type" : "@type",

        "ldp" : "http://www.w3.org/ns/ldp#",
        "RequestError" : "ldp:RequestError",
        "Gone" : "ldp:Gone",
        "NotFound" : "ldp:NotFound",
        "Container" : "ldp:Container",
        "BasicContainer" : "ldp:BasicContainer",
        "DirectContainer" : "ldp:DirectContainer",
        "IndirectContainer" : "ldp:IndirectContainer",
        "hasMemberRelation" : { "@id" : "ldp:hasMemberRelation", "@type" : "@id" },
        "isMemberOfRelation" : { "@id" : "ldp:isMemberOfRelation", "@type" : "@id" },
        "membershipResource" : { "@id" : "ldp:membershipResource", "@type" : "@id" },
        "insertedContentRelation" : { "@id": "ldp:insertedContentRelation", "@type" : "@id" },
        "contains" : { "@id" : "ldp:contains", "@type" : "@id" },
        "member" : { "@id" : "ldp:member", "@type" : "@id" },
        "constrainedBy" : { "@id" : "ldp:constrainedBy", "@type" : "@id" },
        "Resource" : "ldp:Resource",
        "RDFSource" : "ldp:RDFSource",
        "NonRDFSource" : "ldp:NonRDFSource",
        "MemberSubject" : "ldp:MemberSubject",
        "PreferContainment" : "ldp:PreferContainment",
        "PreferMembership" : "ldp:PreferMembership",
        "PreferMinimalContainer" : "ldp:PreferMinimalContainer",
        "PageSortCriterion" : "ldp:PageSortCriterion",
        "pageSortCriteria" : { "@id" : "ldp:pageSortCriteria", "@type" : "@id", "@container" : "@list" },
        "pageSortPredicate" : { "@id" : "ldp:pageSortPredicate", "@type" : "@id" },
        "pageSortOrder" : { "@id" : "ldp:pageSortOrder", "@type" : "@id" },
        "pageSortCollation" : { "@id" : "ldp:pageSortCollation", "@type" : "@id" },
        "Ascending" : "ldp:Ascending",
        "Descending" : "ldp:Descending",
        "Page" : "ldp:Page",
        "pageSequence" : { "@id" : "ldp:pageSequence", "@type" : "@id" },
        "inbox" : { "@id" : "ldp:inbox", "@type" : "@id" },

        "ebucore" : "http://www.ebu.ch/metadata/ontologies/ebucore/ebucore#",
        "hasRelatedImage" : { "@id" : "ebucore:hasRelatedImage", "@type" : "@id" },
        "hasRelatedMediaFragment" : { "@id" : "ebucore:hasRelatedMediaFragment", "@type" : "@id" },

        "dc" : "http://purl.org/dc/",
        "dce" : "dc:elements/1.1/",
        "description" : { "@id" : "dce:description" },
        "publisher" : { "@id" : "dce:publisher" },
        "subject" : { "@id" : "dce:subject" },
        "dct" : "dc:terms/",
        "title" : { "@id" : "dct:title" },
        "dateSubmitted" : { "@id": "dct:dateSubmitted", "@type" : "XMLSchema:dateTime" },
        "modified" : { "@id" : "dct:modified", "@type" : "XMLSchema:dateTime" },
        "hasPart" : { "@id" : "dct:hasPart", "@container" : "@set", "@type" : "@id" },

        "foaf" : "http://xmlns.com/foaf/0.1/",
        "family_name" : { "@id" : "foaf:family_name" },
        "givenname" : { "@id" : "foaf:givenname" },

        "XMLSchema" : "http://www.w3.org/2001/XMLSchema#",
        "created" : { "@id" : "repository:created", "@type" : "XMLSchema:dateTime" },
        "created_by" : { "@id" : "created:By" },

        "repository" : "http://fedora.info/definitions/v4/repository#",
        "exportsAs" : { "@id" : "repository:exportsAs", "@type" : "@id" },
        "hasParent" : { "@id" : "repository:hasParent", "@type" : "@id" },
        "lastModified" : { "@id" : "repository:lastModified", "@type" : "XMLSchema:dateTime" },
        "lastModified_by" : { "@id" : "lastModified:By" },
        "numberOfChildren" : { "@id" : "repository:numberOfChildren", "@type" : "XMLSchema:long" },
        "writable" : { "@id" : "repository:writable", "@type" : "XMLSchema:boolean" },
        "hasTransactionProvider" : { "@id" : "repository:hasTransactionProvider", "@type" : "@id" },

        "fedora-model" : "info:fedora/fedora-system:def/model#",
        "rdf" : "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
        "hasModel" : { "@id" : "fedora-model:hasModel" }, //, "@type" : "rdf:type" },

        "fulcrum" : "http://fulcrum.org/ns#",
        "isbnEbook" : { "@id" : "fulcrum:isbnEbook" },
        "isbnSoftcover" : { "@id" : "fulcrum:isbnSoftcover" },

        "schema" : "http://schema.org/",
        "isbn" : { "@id" : "schema:isbn" },
        "sameAs" : { "@id" : "schema:sameAs" },
        "isPartOf" : { "@id" : "schema:isPartOf" },

        "relators" : "http://id.loc.gov/vocabulary/relators/",
        "dpt" : { "@id" : "relators:dpt" },
        "pbl" : { "@id" : "relators:pbl" },

        "relation" :"http://www.iana.org/assignments/relation/",
        "first" : { "@id" : "relation:first", "@type" : "@id" },
        "prev" : { "@id" : "relation:prev", "@type" : "@id" },
        "next" : { "@id" : "relation:next", "@type" : "@id" },
        "last" : { "@id" : "relation:last", "@type" : "@id" },

        "acl" : "http://www.w3.org/ns/auth/acl#",
        "accessControl" : { "@id" : "acl:accessControl", "@type" : "@id" },
        "accessTo" : { "@id" : "acl:accessTo", "@type" : "@id" },
        "agent" : { "@id" : "acl:agent", "@type" : "@id" },
        "mode" : { "@id" : "acl:mode", "@type" : "@id" },

        "person" : "http://projecthydra.org/ns/auth/person#",

        "pcdm" : "http://pcdm.org/models#",
        "hasMember" : { "@id" : "pcdm:hasMember", "@container" : "@set", "@type" : "@id" },
        "hasFile" : { "@id" : "pcdm:hasFile", "@type" : "@id" },

        "ore" : "http://www.openarchives.org/ore/",
        "oret" : "ore:terms/",
        "proxyFor" : { "@id" : "oret:proxyFor", "@type" : "@id" },
        "proxyIn" : { "@id" : "oret:proxyIn", "@type" : "@id" },

        "gk" : "http://www.gkostin.com/ns#",
        "gkp" : "http://www.gkostin.com/ns/HTTParty#",
        "Response" : { "@id" : "gkp:Response" },
        "Response#request" : { "@id" : "gkp:Response:request", "@type" : "XMLSchema:string" },
        "Response#response" : { "@id" : "gkp:Response:response", "@type" : "XMLSchema:string" },
        "Response#code" : { "@id" : "gkp:Response:code", "@type" : "XMLSchema:long" },
        "Response#headers" : { "@id" : "gkp:Response:headers", "@type" : "XMLSchema:string" },
        "Response#body" : { "@id" : "gkp:Response:body", "@type" : "XMLSchema:string" }
      }
    }))['@context']

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