# frozen_string_literal: true

class PoiCrawlSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :poi, serializer: PoiSerializer
end
