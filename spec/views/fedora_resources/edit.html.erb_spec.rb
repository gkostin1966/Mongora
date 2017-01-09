require 'rails_helper'

RSpec.describe "fedora_resources/edit", type: :view do
  before(:each) do
    @fedora_resource = assign(:fedora_resource, FedoraResource.create!(
      :name => "MyString",
      :identifier => "MyString",
      :path => "MyString"
    ))
  end

  it "renders the edit fedora_resource form" do
    render

    assert_select "form[action=?][method=?]", fedora_resource_path(@fedora_resource), "post" do

      assert_select "input#fedora_resource_name[name=?]", "fedora_resource[name]"

      assert_select "input#fedora_resource_identifier[name=?]", "fedora_resource[identifier]"

      assert_select "input#fedora_resource_path[name=?]", "fedora_resource[path]"
    end
  end
end
