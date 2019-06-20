# frozen_string_literal: true

require 'rails_helper'

describe CrawlUsersController do
  render_views

  describe 'POST #create' do
    context 'user is logged' do
      it 'returns created crawl_user' do
        crawl = FactoryBot.create :crawl
        user = FactoryBot.create :user
        object = FactoryBot.build :crawl_user
        object.crawl = crawl
        object.user = user

        connect_user = crawl.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
        request.headers.merge! auth_headers

        post :create, params: { crawl_id: crawl, crawl_user: object.attributes }

        expect(response.status).to eq 200
      end
    end

    it 'returns 400' do
      crawl = FactoryBot.create :crawl
      user = FactoryBot.create :user
      object = FactoryBot.build :crawl_user
      object.crawl = crawl
      object.user = user

      connect_user = crawl.user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      post :create, params: { crawl_id: crawl, crawl_user: object.attributes.except('user_id') }

      expect(response.status).to eq 400
    end

    it 'returns 403' do
      crawl = FactoryBot.create :crawl
      user = FactoryBot.create :user
      object = FactoryBot.build :crawl_user
      object.crawl = crawl
      object.user = user

      connect_user = FactoryBot.create :user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      post :create, params: { crawl_id: crawl, crawl_user: object.attributes }

      expect(response.status).to eq 403
    end

    context 'user is not logged' do
      it 'returns error 401' do
        crawl = FactoryBot.create :crawl
        user = FactoryBot.create :user
        object = FactoryBot.build :crawl_user
        object.crawl = crawl
        object.user = user

        post :create, params: { crawl_id: crawl, crawl_user: object.attributes }

        expect(response.status).to eq 401
      end
    end
  end

  describe 'PATCH #update' do
    context 'user is logged' do
      it 'returns 200' do
        object = FactoryBot.create :crawl_user

        connect_user = object.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
        request.headers.merge! auth_headers

        patch :update, params: { crawl_id: object.crawl_id, id: object.id, crawl_user: { accepted: 1 } }

        expect(response.status).to eq 200
      end
    end

    it 'returns 403' do
      object = FactoryBot.create :crawl_user

      connect_user = FactoryBot.create :user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      patch :update, params: { crawl_id: object.crawl_id, id: object.id, crawl_user: { accepted: 0 } }

      expect(response.status).to eq 403
    end

    it 'returns 404' do
      object = FactoryBot.create :crawl_user

      connect_user = FactoryBot.create :user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      patch :update, params: { crawl_id: object.crawl_id, id: 999_999, crawl_user: { accepted: 0 } }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        object = FactoryBot.create :poi_crawl

        patch :update, params: { crawl_id: object.crawl_id, id: 1, crawl: FactoryBot.build(:crawl_user) }
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user is logged' do
      it 'as guest returns 200' do
        object = FactoryBot.create :crawl_user

        connect_user = object.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
        request.headers.merge! auth_headers

        delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }

        expect(response.status).to eq 200
      end

      it 'as owner returns 200' do
        object = FactoryBot.create :crawl_user

        connect_user = object.crawl.user
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
        request.headers.merge! auth_headers

        delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }

        expect(response.status).to eq 200
      end
    end

    it 'returns 403' do
      object = FactoryBot.create :crawl_user

      connect_user = FactoryBot.create :user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }

      expect(response.status).to eq 403
    end

    it 'returns 404 for owner' do # as owner
      object = FactoryBot.create :crawl_user

      connect_user = object.crawl.user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      delete :destroy, params: { crawl_id: FactoryBot.create(:crawl).id, id: 999_999 }

      expect(response.status).to eq 404
    end
    it 'returns 404 for guest' do
      object = FactoryBot.create :crawl_user

      connect_user = object.user
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, connect_user)
      request.headers.merge! auth_headers

      delete :destroy, params: { crawl_id: FactoryBot.create(:crawl).id, id: 999_999 }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        object = FactoryBot.create :crawl_user

        delete :destroy, params: { crawl_id: object.crawl_id, id: object.id }

        expect(response.status).to eq 401
      end
    end
  end
end
