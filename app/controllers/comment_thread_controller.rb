# frozen_string_literal: true

class CommentThreadController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    render json: CommentThreadSerializer.new(
      CommentThread.eager_load(comments: :user).find(params[:id])
    ).serialized_json
  end
end
