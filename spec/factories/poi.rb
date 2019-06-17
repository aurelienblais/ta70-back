# frozen_string_literal: true

FactoryBot.define do
  factory :poi do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:address) { |n| "Address #{n}" }
    lat { 10.0 }
    lng { 12.2 }
    sequence(:phone) { |n| "Phone #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    family { :bar }
  end
end
