# frozen_string_literal: true

module Commentable
  extend ActiveSupport::Concern

  included do
    has_one :comment_thread, as: :commentable
    has_many :comments, through: :comment_thread

    before_save :build_comment_thread!
    before_destroy :destroy_comment_thread!

    private

    def build_comment_thread!
      build_comment_thread unless comment_thread
    end

    def destroy_comment_thread!
      comment_thread.destroy!
    end
  end
end
