require 'rails_helper'
# rubocop:disable Rails/ApplicationController, RSpec/FilePath

class DummyController < ActionController::Base
  include SerializationConcern
  include ReactComponentConcern
  before_action :dummy_json
  def dummy_json
    render json: {}, status: :ok
  end

  def index; end

  def index_props
    { some_prop_name: 'some_prop_value' }
  end
end

describe DummyController, type: :request do
  before do
    Rails.application.routes.draw do
      get '/dummy/index', to: 'dummy#index'
    end
  end

  context 'when a request renders a react component' do
    it 'adds the props for that action' do
      get '/dummy/index'
      expect(controller.instance_variable_get(:@component_props)).to include(
        {
          some_prop_name: 'some_prop_value'
        }
      )
    end

    it 'adds the default props' do
      get '/dummy/index'
      expect(controller.instance_variable_get(:@component_props)).to include(
        {
          ongoingPlaylist: anything,
          votation: anything
        }
      )
    end
  end
end

# rubocop:enable Rails/ApplicationController, RSpec/FilePath
