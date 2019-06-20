# frozen_string_literal: true

require 'rails_helper'

describe FriendshipsController do
  render_views

  describe 'GET #index' do
    context 'user is logged' do
      it 'returns all friends' do
        object = FactoryBot.create :friendship

        user         = object.user
        headers      = { 'Accept' => 'applicatilon/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        get :index

        expect(response.body).to include object.friend.name
      end
    end

    context 'user is not logged' do
      it 'returns error' do
        get :index
        expect(response.status).to eq 401
      end
    end
  end

  describe 'GET #waiting' do
    context 'user is logged' do
      it 'returns all pending requests' do
        object = FactoryBot.create :friendship
        object.update_attributes(accepted: false)

        user         = object.friend
        headers      = { 'Accept' => 'applicatilon/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        get :waiting

        expect(response.body).to include object.user.name
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
      it 'returns created friendship' do
        friend = FactoryBot.create :user

        user         = FactoryBot.create :user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        post :create, params: { friendship: { email: friend.email } }

        expect(response.status).to eq 200
      end
    end

    it 'returns 400' do
      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      post :create, params: { friendship: { email: '' } }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        post :create, params: { friendship: FactoryBot.build(:friendship) }
        expect(response.status).to eq 401
      end
    end
  end

  describe 'PATCH #updated' do
    context 'user is logged' do
      it 'returns updated friendship' do
        object = FactoryBot.create :friendship

        user         = object.friend
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        patch :update, params: { id: object.id, friendship: { accepted: true } }

        expect(response.status).to eq 200
      end

      it 'returns 403' do
        object = FactoryBot.create :friendship

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        patch :update, params: { id: object.id, friendship: { accepted: true } }

        expect(response.status).to eq 403
      end

      it 'returns 404' do
        user         = FactoryBot.create :user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        patch :update, params: { id: 999_999, friendship: { accepted: true } }

        expect(response.status).to eq 404
      end
    end

    it 'returns 400' do
      expect do
        object = FactoryBot.create :friendship

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        patch :update, params: { id: object.id, friendship: { accepted: nil } }
      end.to raise_exception Apipie::ParamInvalid
    end

    context 'user is not logged' do
      it 'returns error' do
        object = FactoryBot.create :friendship

        patch :update, params: { id: object.id, params: { friendship: { accepted: true } } }
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user is logged' do
      it 'returns 200' do
        object = FactoryBot.create :friendship

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        delete :destroy, params: { id: object.id }

        expect(response.status).to eq 200
      end
    end

    context 'user is logged' do
      it 'returns 200' do
        object = FactoryBot.create :friendship

        user         = object.friend
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        delete :destroy, params: { id: object.id }

        expect(response.status).to eq 200
      end
    end

    it 'returns 403' do
      object = FactoryBot.create :friendship

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
