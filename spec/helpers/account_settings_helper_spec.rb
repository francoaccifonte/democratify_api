require 'rails_helper'

class DummyHelper
  include AccountSettingsHelper
end

RSpec.describe AccountSettingsHelper do
  let(:account) { create(:account) }

  describe '.serialized_account' do
    subject { DummyHelper.new.serialized_account(account) }

    it 'provides a serialized account' do
      expect(subject).to include("\"id\":#{account.id}")
    end
  end
end
