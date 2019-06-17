# frozen_string_literal: true

class PoiCrawl < ApplicationRecord
  belongs_to :crawl
  belongs_to :poi
end
