# frozen_string_literal: true

require 'rails_helper'

describe PoiCrawlsController do
  render_views

  describe 'GET #index' do
    context 'user is logged' do
      it 'returns all pois from a crawl' do
        object = FactoryBot.create :poi_crawl

        user = object.crawl.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        get :index, params: { crawl_id: object.crawl }

        expect(response.body).to include object.poi.name
      end

      it 'returns error' do
        object = FactoryBot.create :poi_crawl

        user = FactoryBot.create :user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        get :index, params: { crawl_id: object.crawl }
        expect(response.status).to eq 403
      end

      context 'user is not logged' do
        it 'returns error' do
          object = FactoryBot.create :poi_crawl

          get :index, params: { crawl_id: object.crawl }
          expect(response.status).to eq 401
        end
      end
    end
  end

  describe 'POST #create' do
    context 'user is logged' do
      it 'returns created poi_crawl' do
        crawl = FactoryBot.create :crawl
        poi = FactoryBot.create :poi
        object = FactoryBot.build :poi_crawl
        object.crawl = crawl
        object.poi = poi

        user = crawl.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        post :create, params: { crawl_id: crawl, poi_crawl: object.attributes }

        expect(response.status).to eq 200
      end
    end

    it 'returns 400' do
      crawl = FactoryBot.create :crawl
      poi = FactoryBot.create :poi
      object = FactoryBot.build :poi_crawl
      object.crawl = crawl
      object.poi = poi

      user = crawl.user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      post :create, params: { crawl_id: crawl, poi_crawl: object.attributes.except('poi_id') }

      expect(response.status).to eq 400
    end
  end

  it 'returns 403' do
    crawl = FactoryBot.create :crawl
    poi = FactoryBot.create :poi
    object = FactoryBot.build :poi_crawl
    object.crawl = crawl
    object.poi = poi

    user = FactoryBot.create :user
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
    request.headers.merge! auth_headers

    post :create, params: { crawl_id: crawl, poi_crawl: object.attributes }

    expect(response.status).to eq 403
  end

  context 'user is not logged' do
    it 'returns error' do
      crawl = FactoryBot.create :crawl
      poi = FactoryBot.create :poi
      object = FactoryBot.build :poi_crawl
      object.crawl = crawl
      object.poi = poi

      post :create, params: { crawl_id: crawl, poi_crawl: object.attributes }

      expect(response.status).to eq 401
    end
  end

  describe 'DELETE #destroy' do
    context 'user is logged' do
      it 'returns 200' do
        object = FactoryBot.create :poi_crawl

        user = object.crawl.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }

        expect(response.status).to eq 200
      end
    end

    it 'returns 403' do
      object = FactoryBot.create :poi_crawl

      user = FactoryBot.create :user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }

      expect(response.status).to eq 403
    end

    it 'returns 404' do
      user = FactoryBot.create :user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      delete :destroy, params: { crawl_id: FactoryBot.create(:crawl).id, id: 999_999 }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        object = FactoryBot.create :poi_crawl

        delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }
        expect(response.status).to eq 401
      end
    end
  end
end
