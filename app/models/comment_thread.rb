# frozen_string_literal: true

class CommentThread < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :commentable, polymorphic: true
end
