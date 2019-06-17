# frozen_string_literal: true

class PoiShortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :lat, :lng
end
