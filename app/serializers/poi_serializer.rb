# frozen_string_literal: true

class PoiSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address, :phone, :description, :lat, :lng
  attributes :opening_hours, :menu_items, :events
end
