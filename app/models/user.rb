# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  ROLES = %w[user admin].freeze

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :crawl_users
  has_many :crawls, through: :crawl_users

  has_one :poi_user, required: false
  has_one :poi, through: :poi_user, required: false

  validates_presence_of :firstname, :lastname
  validates_inclusion_of :roles, in: ROLES

  before_validation :set_role

  def name
    "#{firstname.capitalize} #{lastname.capitalize[0]}."
  end

  ROLES.each do |role|
    define_method("#{role}?".to_sym) do
      roles == role
    end
  end

  private

  def set_role
    self.roles ||= 'user'
  end
end
