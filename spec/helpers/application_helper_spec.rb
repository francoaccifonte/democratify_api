require 'rails_helper'

class DummyHelper
  include ApplicationHelper
end

RSpec.describe ApplicationHelper do
  let(:account) { create(:account) }

  describe '.serialized_account' do
    subject { DummyHelper.new.serialized_account(account, options:) }

    context 'with default options' do
      let(:options) { {} }

      it 'provides a serialized account' do
        expect(subject).to include("\"id\":#{account.id}")
        expect(subject).not_to include("token")
      end
    end

    context 'with custom options' do
      let(:options) { {except: %i[email]} }

      it 'is customizable' do
        expect(subject).not_to include("email")
        expect(subject).not_to include("token")
      end
    end
  end
end
