# frozen_string_literal: true

FactoryBot.define do
  factory :comment_thread do
    commentable { |c| c.association(:poi) }
  end
end
