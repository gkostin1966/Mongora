module FedoraHelper
  def table_row_property(property)
    value = @fedora[property]
    unless value.nil?
      if value.is_a?(Array)
        td_array = []
        td_array.push "<td>#{property}</td>"
        td_array.push *value.collect { |v| content_tag(:td, v) }
        content_tag(:tr) do
          td_array.join(" ").html_safe
        end
      else
        content_tag(:tr) do
          content_tag(:td) do
            property
          end +
          content_tag(:td) do
            value
          end
        end
      end
    end
  end

  def table_row_resource_link(resource)
    value = @fedora[resource]
    unless value.nil?
      if value.is_a?(Array)
        td_array = []
        td_array.push "<td>#{resource}</td>"
        td_array.push *value.collect { |v| content_tag(:td, link_to(v, fedora_path(v.gsub('/','|')))) }
        content_tag(:tr) do
          td_array.join(" ").html_safe
        end
      else
        content_tag(:tr) do
          content_tag(:td) do
            resource
          end +
          content_tag(:td) do
            link_to(value, fedora_path(value.gsub('/','|')))
          end
        end
      end
    end
  end
end
