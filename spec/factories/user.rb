# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@test.com" }
    sequence(:firstname) { |n| "Firstname #{n}" }
    sequence(:lastname) { |n| "Lastname #{n}" }
    password { '123456' }
    password_confirmation { password }
  end
end
