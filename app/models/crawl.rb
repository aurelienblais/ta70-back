# frozen_string_literal: true

class Crawl < ApplicationRecord
  include Commentable

  belongs_to :user
  has_many :poi_crawls
  has_many :pois, through: :poi_crawls
  has_many :crawl_users
  has_many :users, through: :crawl_users
end
