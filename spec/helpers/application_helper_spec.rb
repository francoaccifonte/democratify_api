require 'rails_helper'

class DummyHelper
  include ApplicationHelper
end

RSpec.describe ApplicationHelper do
  let(:account) { create(:account) }
  let(:playlists) { create_list(:spotify_playlist, 3, account:) }

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
      let(:options) { { except: %i[email] } }

      it 'is customizable' do
        expect(subject).not_to include("email")
        expect(subject).not_to include("token")
      end
    end
  end

  describe '.serialized_spotify_playlists' do
    subject { DummyHelper.new.serialized_spotify_playlists(playlists) }

    it 'provides a serialized list of playlists' do
      playlists.each do |sp|
        expect(subject).to include("\"id\":#{sp.id}")
      end
    end
  end
end
