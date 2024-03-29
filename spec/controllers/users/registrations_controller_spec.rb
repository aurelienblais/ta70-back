# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /sign_up', type: :request do
  let(:url) { '/users' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password',
        firstname: 'Test',
        lastname: 'test'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      expect(response.body).to include params[:user][:email]
    end
  end

  context 'when user already exists' do
    before do
      FactoryBot.create :user, email: params[:user][:email]
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      expect(response.body).to include 'Bad Request'
    end
  end
end
