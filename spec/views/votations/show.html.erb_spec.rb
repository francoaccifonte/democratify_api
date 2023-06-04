require 'rails_helper'

RSpec.describe "votations/show", type: :view do
  before(:each) do
    @votation = assign(:votation, Votation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
