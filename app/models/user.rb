# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :pub_crawl_users
  has_many :pub_crawls, through: :pub_crawl_users

  has_one :pub_user, required: false
  has_one :pub, through: :pub_user, required: false
end
