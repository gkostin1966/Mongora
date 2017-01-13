class Fedora
  include HTTParty
  debug_output #stdout
  base_uri 'http://localhost:8984'
  headers 'Accept' => 'application/ld+json'
  format :json

  def self.rest(relative_id)
    id = base_uri + '/' + relative_id
    response = get(id)
    json_ld = response
    response.parsed_response.each do |element|
      if element["@id"] == id
        json_ld = element
      end
    end

    context = JSON.parse(%({
      "@context" : {
        "id" : "@id",
        "type" : "@type",

        "ldp" : "http://www.w3.org/ns/ldp#",
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

        "gkostin" : "http://gkostin.com#"
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