require 'rails_helper'

class DummyHelper
  include ApplicationHelper
end

describe SerializationConcern do
  context 'when serializing stuff' do
    let!(:accounts) { create_list(:account, 2) }

    describe '.serialize_one' do
      it 'just works' do
        response = DummyHelper.new.serialize_one(Account.first)
        expect(response).to include("\"id\":#{Account.first.id}")
      end

      it 'can be customized' do
        response = DummyHelper.new.serialize_one(Account.first, options: { except: [:id] })
        expect(response).not_to include("\"id\":#{Account.first.id}")
        expect(response).to include("\"name\":\"#{Account.first.name}\"")
      end
    end

    describe '.serialize_many' do
      it 'just works' do
        response = DummyHelper.new.serialize_many(Account.all)
        expect(response).to include("\"id\":#{Account.first.id}")
        expect(response).to include("\"id\":#{Account.last.id}")
      end

      it 'can be customized' do
        response = DummyHelper.new.serialize_many(Account.all, options: { except: [:id] })
        expect(response).not_to include("\"id\":#{Account.first.id}")
        expect(response).not_to include("\"id\":#{Account.last.id}")
        expect(response).to include("\"name\":\"#{Account.first.name}\"")
        expect(response).to include("\"name\":\"#{Account.last.name}\"")
      end
    end
  end
end
