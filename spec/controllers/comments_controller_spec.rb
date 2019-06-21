# frozen_string_literal: true

require 'rails_helper'

describe CommentsController do
  render_views

  describe 'POST #create' do
    context 'user is logged' do
      it 'returns created comment' do
        object = FactoryBot.build :comment
        object.comment_thread = FactoryBot.create :comment_thread
        object.user = FactoryBot.create :user

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        post :create, params: { comment_thread_id: object.comment_thread_id, comment: object.attributes }

        expect(response.status).to eq 200
        expect(response.body).to include object.comment
      end
    end

    context 'user is not logged' do
      it 'returns error' do
        object = FactoryBot.build :comment
        object.comment_thread = FactoryBot.create :comment_thread

        post :create, params: { comment_thread_id: object.comment_thread_id, comment: object.attributes.except('comment') }
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user is logged' do
      it 'returns 200' do
        object = FactoryBot.create :comment

        user         = object.user
        headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        request.headers.merge! auth_headers

        delete :destroy, params: { comment_thread_id: object.comment_thread_id, id: object.id }

        expect(response.status).to eq 200
      end
    end

    it 'returns 403' do
      object = FactoryBot.create :comment

      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      delete :destroy, params: { comment_thread_id: object.comment_thread_id, id: object.id }

      expect(response.status).to eq 403
    end

    it 'returns 404' do
      user         = FactoryBot.create :user
      headers      = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      request.headers.merge! auth_headers

      delete :destroy, params: { comment_thread_id: 1, id: 999_999 }

      expect(response.status).to eq 404
    end

    context 'user is not logged' do
      it 'returns error' do
        delete :destroy, params: { comment_thread_id: 1, id: 1 }
        expect(response.status).to eq 401
      end
    end
  end
end
