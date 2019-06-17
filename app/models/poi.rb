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
end
