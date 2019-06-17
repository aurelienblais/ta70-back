# frozen_string_literal: true

class Crawl < ApplicationRecord
  include Commentable

  STATUS = %w[draft published public].freeze

  belongs_to :user
  has_many :poi_crawls
  has_many :pois, through: :poi_crawls
  has_many :crawl_users
  has_many :users, through: :crawl_users

  before_validation :set_status
  validates_inclusion_of :status, in: STATUS
  validates_presence_of :name

  private

  def set_status
    self.status ||= 'draft'
  end
end
