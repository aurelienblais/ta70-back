# frozen_string_literal: true

FactoryBot.define do
  factory :crawl do
    sequence(:name) { |n| "Crawl #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    event_date { DateTime.now }
    status { :draft }
    user
  end
end
