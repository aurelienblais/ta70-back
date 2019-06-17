# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    event_date { DateTime.now }
    poi
  end
end
