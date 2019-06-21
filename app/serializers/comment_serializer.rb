# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer
  # Attributes
  attributes :comment, :note, :created_at

  attributes :user do |comment|
    {
      id: comment.user_id,
      name: comment.user.name
    }
  end
end
