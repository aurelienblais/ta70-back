# frozen_string_literal: true

require 'rails_helper'

describe CrawlsController do
  render_views

  describe 'GET #index' do
    context 'user is logged' do
      it 'returns all crawls' do
        object = FactoryBot.create :crawl

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        get :index

        expect(response.body).to include object.name
      end
    end

    context 'user is not logged' do
      it 'returns error' do
        get :index
        expect(response.status).to eq 401
      end
    end
  end

  describe 'POST #create' do
    context 'user is logged' do
      it 'returns created crawls' do
        object = FactoryBot.build :crawl

        user         = FactoryBot.create :user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        post :create, params: { crawl: object.attributes }

        expect(response.status).to eq 200
        expect(response.body).to include object.name
      end
    end

    it 'returns 400' do
      object = FactoryBot.build :crawl

      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      post :create, params: { crawl: object.attributes.except('name') }

      expect(response.status).to eq 400
    end

    context 'user is not logged' do
      it 'returns error' do
        post :create, params: { crawl: FactoryBot.build(:crawl) }
        expect(response.status).to eq 401
      end
    end
  end

  describe 'PATCH #update' do
    context 'user is logged' do
      it 'returns updated crawls' do
        object = FactoryBot.create :crawl

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        patch :update, params: { id: object.id, crawl: { name: 'updated-name' } }

        expect(response.status).to eq 200
        expect(response.body).to include 'updated-name'
      end
    end

    it 'returns 400' do
      object = FactoryBot.create :crawl

      user         = object.user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      patch :update, params: { id: object.id, crawl: { name: '' } }

      expect(response.status).to eq 400
    end

    it 'returns 403' do
      object = FactoryBot.create :crawl

      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      patch :update, params: { id: object.id, crawl: { name: 'Test' } }

      expect(response.status).to eq 403
    end

    it 'returns 404' do
      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      patch :update, params: { id: 999_999, crawl: { name: 'test' } }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        patch :update, params: { id: 1, crawl: FactoryBot.build(:crawl) }
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user is logged' do
      it 'returns 200' do
        object = FactoryBot.create :crawl

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        delete :destroy, params: { id: object.id }

        expect(response.status).to eq 200
      end
    end

    it 'returns 403' do
      object = FactoryBot.create :crawl

      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      delete :destroy, params: { id: object.id }

      expect(response.status).to eq 403
    end

    it 'returns 404' do
      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      delete :destroy, params: { id: 999_999 }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        delete :destroy, params: { id: 1 }
        expect(response.status).to eq 401
      end
    end
  end
end
