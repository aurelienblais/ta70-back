# frozen_string_literal: true

class CrawlPoiSerializer
  include FastJsonapi::ObjectSerializer

  attributes :poi do |crawl_poi|
    {
      id: crawl_poi.poi.id,
      name: crawl_poi.poi.name
    }
  end
end
