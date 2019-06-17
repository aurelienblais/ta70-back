# frozen_string_literal: true

require 'rails_helper'

describe HelloController do
  render_views

  describe 'GET #index' do
    it 'returns 200' do
      get :index
      expect(response.status).to eq 200
    end
  end
end
