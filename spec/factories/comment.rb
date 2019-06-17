# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    sequence(:comment) { |n| "Comment #{n}" }
    note { 5 }
    user
    comment_thread
  end
end
