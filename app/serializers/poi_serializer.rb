# frozen_string_literal: true

class PoiSerializer
  include FastJsonapi::ObjectSerializer
  # Attributes
  attributes :name, :address, :phone, :description, :lat, :lng

  # Methods
  attributes :parsed_opening_hours

  # Relations
  attributes :menu_items, :events
end
