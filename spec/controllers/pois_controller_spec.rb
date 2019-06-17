# frozen_string_literal: true

require 'rails_helper'

describe PoisController do
  render_views

  describe 'GET #index' do
    it 'returns all pois' do
      object = FactoryBot.create :poi
      get :index, params: { lat: object.lat, lng: object.lng }, as: :json
      expect(response.body).to include object.name
    end
  end
end
