require 'rails_helper'

RSpec.describe "fedora_resources/show", type: :view do
  before(:each) do
    @fedora_resource = assign(:fedora_resource, FedoraResource.create!(
      :name => "Name",
      :identifier => "Identifier",
      :path => "Path"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Identifier/)
    expect(rendered).to match(/Path/)
  end
end
