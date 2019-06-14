# frozen_string_literal: true

class PubCrawl < ApplicationRecord
  include Commentable

  belongs_to :user
  has_many :pub_crawl_pubs
  has_many :pub, through: :pub_crawl_pubs
  has_many :pub_crawl_users
  has_many :users, through: :pub_crawl_users
end
