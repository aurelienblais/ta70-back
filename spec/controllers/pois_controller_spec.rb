# frozen_string_literal: true

require 'rails_helper'

describe PoisController do
  render_views

  describe 'GET #index' do
    it 'returns all pois' do
      object = FactoryBot.create :poi
      get :index, params: { lat: object.lat, lng: object.lng }
      expect(response.body).to include object.name
    end

    it 'returns error' do
      get :index
      expect(response.status).to eq 400
    end
  end

  describe 'GET #show' do
    it 'returns given poi' do
      object = FactoryBot.create :poi
      get :show, params: { id: object.id }
      expect(response.body).to include object.name
    end

    it 'returns error' do
      get :show, params: { id: 999_999 }
      expect(response.status).to eq 404
    end
  end
end
