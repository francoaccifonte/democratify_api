require 'rails_helper'

RSpec.describe "Welcomes" do
  describe "GET /index" do
    context 'when user is logged in' do
      before { WithAccountCookies.set_account_cookie(cookies) }

      it 'returns http success' do
        get '/'
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not logged in' do
      it 'returns http success' do
        get '/'
        expect(response).to have_http_status(:success)
      end
    end
  end
end
