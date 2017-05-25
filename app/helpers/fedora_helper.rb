module FedoraHelper
  def table_row_property(property)
    value = @node[property]
    unless value.nil?
      # if value.is_a?(Array)
      #   td_array = []
      #   td_array.push "<td>#{property}</td>"
      #   # td_array.push *value.collect { |v| content_tag(:td, v) }
      #   td_array.push "<td>#{value.inspect}</td>"
      #   content_tag(:tr) do
      #     td_array.join(" ").html_safe
      #   end
      # else
      content_tag(:tr) do
        content_tag(:td) do
          property
        end +
            content_tag(:td) do
              value
            end
      end
      # end
    end
  end

  def table_row_resource_link(resource)
    value = @node[resource]
    unless value.nil?
      if value.is_a?(Array)
        td_array = []
        td_array.push "<td>#{resource}</td>"
        # td_array.push *value.collect { |v| content_tag(:td, link_to(v, fedora_node_path(v.gsub('/','|')))) + content_tag(:td) { (FedoraService.rest(v))["hasModel"] }}
        td_array.push *value.collect { |v| content_tag(:td, (link_to(v, fedora_node_path(v))) + " " +(Fedora.rest(v))["hasModel"]) }
        content_tag(:tr) do
          td_array.join(" ").html_safe
        end
      else
        content_tag(:tr) do
          content_tag(:td) do
            resource
          end +
              content_tag(:td) do
                # link_to(value, fedora_node_path(value.gsub('/','|')))
                link_to(value, fedora_node_path(value)) + " " + (Fedora.rest(value))["hasModel"]
                # end +
                # content_tag(:td) do
                #   (FedoraService.rest(value))["hasModel"]
              end
        end
      end
    end
  end
end
