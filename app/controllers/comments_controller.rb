# frozen_string_literal: true

class CommentsController < ApplicationController
  api :POST, '/comment_thread/:comment_thread_id/comments'
  param :comment, Hash do
    param :comment, String, desc: 'Content'
    param :note, :number, desc: 'Note'
  end
  returns code: 200, desc: 'Return created crawl' do
    property :id, :number, desc: 'Comment id'
    property :comment, String, desc: 'Comment content'
    property :note, :number, desc: 'Comment mark'
    property :created_at, DateTime, desc: 'Comment creation'
    property :user, Hash do
      property :id, :number, desc: 'User id'
      property :name, String, desc: 'User name'
    end
  end
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def create
    render json: CommentSerializer.new(
      Comment.create!(comment_params.merge(comment_thread_id: params[:comment_thread_id], user: current_user))
    ).serialized_json
  end

  api :DELETE, '/comment_thread/:comment_thread_id/comments/:id'
  returns code: 200, desc: 'Success'
  returns code: [400, 401, 404], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    authorize @comment, policy_class: CommentPolicy
    @comment.destroy!
    head :ok
  end

  private

  def comment_params
    params.require(:comment).permit(
      :comment,
      :note
    )
  end
end
