# frozen_string_literal: true

class CommentThreadSerializer
  include FastJsonapi::ObjectSerializer

  attribute :can_comment do |comment_thread, params|
    comment_thread.can_comment? params[:user]
  end

  attribute :comments do |comment_thread|
    CommentSerializer.new(comment_thread.comments).as_json
  end
end
