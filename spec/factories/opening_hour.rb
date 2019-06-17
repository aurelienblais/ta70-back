# frozen_string_literal: true

FactoryBot.define do
  factory :opening_hour do
    sequence(:weekday) { |n| n % 6 }
    opening { Time.new(0, 1, 1, 0o7, 0o0) }
    closing { Time.new(0, 1, 1, 18, 0o0) }
    poi
  end
end
