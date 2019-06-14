# frozen_string_literal: true

class Pub < ApplicationRecord
  include Commentable

  has_one :pub_user, required: false
  has_one :user, through: :pub_user, required: false

  has_many :opening_hours
  has_many :menu_items
  has_many :events

  has_many :pub_crawl_pubs
  has_many :pub_crawls, through: :pub_crawl_pubs

  validates_presence_of :name, :address, :coordinates, :phone, :description
end
