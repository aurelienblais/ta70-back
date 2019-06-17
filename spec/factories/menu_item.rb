# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    sequence(:name) { |n| "MenuItem #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    price { 10.00 }
    poi
  end
end
