# frozen_string_literal: true

FactoryBot.define do
  factory :poi do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:address) { |n| "Address #{n}" }
    coordinates { '10.0 12.2' }
    sequence(:phone) { |n| "Phone #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    family { :bar }
  end
end
