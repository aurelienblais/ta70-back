# frozen_string_literal: true

FactoryBot.define do
  factory :friendship do
    user
    association :friend, factory: :user
    accepted { true }
  end
end
