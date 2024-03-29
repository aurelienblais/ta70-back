# frozen_string_literal: true

class CommentThreadShortSerializer
  include FastJsonapi::ObjectSerializer

  attribute :note do |comment_thread|
    comment_thread.comments.average(:note)
  end

  attribute :comments do |comment_thread|
    comment_thread.comments.length
  end
end
