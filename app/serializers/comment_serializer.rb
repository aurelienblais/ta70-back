# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer
  # Attributes
  attributes :comment, :note, :created_at

  # Relations
  attributes :user
end
