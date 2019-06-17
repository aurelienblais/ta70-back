# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :crawl_users
  has_many :crawls, through: :crawl_users

  has_one :poi_user, required: false
  has_one :poi, through: :poi_user, required: false

  validates_presence_of :firstname, :lastname

  before_commit :set_role

  private

  def set_role
    roles ||= 'user'
  end
end
