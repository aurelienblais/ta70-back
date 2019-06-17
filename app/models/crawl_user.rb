# frozen_string_literal: true

class CrawlUser < ApplicationRecord
  belongs_to :user
  belongs_to :crawl
end
