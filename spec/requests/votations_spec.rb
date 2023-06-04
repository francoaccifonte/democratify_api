require 'rails_helper'

RSpec.describe "/votations" do
  describe "GET /show" do
    it "renders a successful response" do
      votation = Votation.create! valid_attributes
      get votation_url(votation)
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested votation" do
        votation = Votation.create! valid_attributes
        patch votation_url(votation), params: { votation: new_attributes }
        votation.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the votation" do
        votation = Votation.create! valid_attributes
        patch votation_url(votation), params: { votation: new_attributes }
        votation.reload
        expect(response).to redirect_to(votation_url(votation))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        votation = Votation.create! valid_attributes
        patch votation_url(votation), params: { votation: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
