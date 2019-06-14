# frozen_string_literal: true

class PubCrawlUser < ApplicationRecord
  belongs_to :user
  belongs_to :pub_crawl
end
