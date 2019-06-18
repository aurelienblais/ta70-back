# frozen_string_literal: true

class PoiCrawl < ApplicationRecord
  belongs_to :crawl
  belongs_to :poi

  validates_uniqueness_of :poi, scope: :crawl
end
