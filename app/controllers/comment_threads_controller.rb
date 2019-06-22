# frozen_string_literal: true

class CommentThreadsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  api :GET, '/comment_threads/:id'
  returns code: 200 do
    property :data, Array do
      property :id, :number, desc: 'Comment id'
      property :comment, String, desc: 'Comment content'
      property :note, :number, desc: 'Comment mark'
      property :created_at, DateTime, desc: 'Comment creation'
      property :user, Hash do
        property :id, :number, desc: 'User id'
        property :name, String, desc: 'User name'
      end
    end
  end
  returns code: 404 do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def show
    @comment_thread = CommentThread.eager_load(comments: :user).find(params[:id])
    render json: CommentThreadSerializer.new(@comment_thread, params: { user: current_user }).serialized_json
  end
end
