require 'rails_helper'

RSpec.describe "fedora_resources/new", type: :view do
  before(:each) do
    assign(:fedora_resource, FedoraResource.new(
      :name => "MyString",
      :identifier => "MyString",
      :path => "MyString"
    ))
  end

  it "renders new fedora_resource form" do
    render

    assert_select "form[action=?][method=?]", fedora_resources_path, "post" do

      assert_select "input#fedora_resource_name[name=?]", "fedora_resource[name]"

      assert_select "input#fedora_resource_identifier[name=?]", "fedora_resource[identifier]"

      assert_select "input#fedora_resource_path[name=?]", "fedora_resource[path]"
    end
  end
end
