# frozen_string_literal: true

class Poi < ApplicationRecord
  include Commentable

  reverse_geocoded_by :lat, :lng

  has_one :poi_user, required: false
  has_one :user, through: :poi_user, required: false

  has_many :opening_hours
  has_many :menu_items
  has_many :events

  has_many :poi_crawls
  has_many :crawls, through: :poi_crawls

  validates_presence_of :name, :lat, :lng

  # Override opening hours to group per day
  def parsed_opening_hours
    @opening_hours ||= opening_hours.group_by(&:weekday).flat_map do |day|
      {
        day[0] => day[1].flat_map do |hour|
          {
            opening: hour.opening,
            closing: hour.closing
          }.reject { |_, v| v.nil? }
        end
      }
    end
  end
end
