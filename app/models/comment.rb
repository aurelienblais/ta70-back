# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :comment_thread
  belongs_to :user
end
