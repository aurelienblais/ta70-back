# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    render json: CommentSerializer.new(
      Comment.create!(comment_params.merge(comment_thread_id: params[:comment_thread_id]))
    ).serialized_json
  end

  def destroy
    @comment = Comment.find params[id]
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
