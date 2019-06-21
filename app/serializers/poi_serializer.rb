# frozen_string_literal: true

class PoiSerializer
  include FastJsonapi::ObjectSerializer
  # Attributes
  attributes :name, :address, :phone, :description, :lat, :lng

  # Methods
  attributes :parsed_opening_hours

  # Relations
  attributes :menu_items

  attribute :events do |poi|
    poi.events.only_upcoming.as_json
  end

  attribute :comment_thread do |poi|
    CommentThreadShortSerializer.new(poi.comment_thread).as_json
  end
end
