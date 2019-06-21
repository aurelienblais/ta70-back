# frozen_string_literal: true

require 'rails_helper'

describe CommentThreadsController do
  render_views

  describe 'GET #show' do
    it 'returns given comment thread' do
      object = FactoryBot.create :comment_thread
      object.comments << FactoryBot.create(:comment)

      get :show, params: { id: object.id }
      expect(response.body).to include object.comments.first.comment
    end

    it 'returns error' do
      get :show, params: { id: 999_999 }
      expect(response.status).to eq 404
    end
  end
end
