# frozen_string_literal: true

class PubCrawlPub < ApplicationRecord
  belongs_to :pub_crawl
  belongs_to :pub
end
