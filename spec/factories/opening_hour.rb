# frozen_string_literal: true

FactoryBot.define do
  factory :opening_hour do
    sequence(:weekday) { |n| n % 6 }
    poi
    opening { Time.new(0, 1, 1, 0o7, 0o0) }

    factory :closed_hour do
      opening { nil }
      closing { Time.new(0, 1, 1, 18, 0o0) }
    end
  end
end
