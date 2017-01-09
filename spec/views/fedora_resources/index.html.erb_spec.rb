require 'rails_helper'

RSpec.describe "fedora_resources/index", type: :view do
  before(:each) do
    assign(:fedora_resources, [
      FedoraResource.create!(
        :name => "Name",
        :identifier => "Identifier",
        :path => "Path"
      ),
      FedoraResource.create!(
        :name => "Name",
        :identifier => "Identifier",
        :path => "Path"
      )
    ])
  end

  it "renders a list of fedora_resources" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Identifier".to_s, :count => 2
    assert_select "tr>td", :text => "Path".to_s, :count => 2
  end
end
