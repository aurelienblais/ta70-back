# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :only_accepted, -> { where(accepted: true) }

  validates_uniqueness_of :friend_id, scope: :user_id

  before_save :set_accepted

  def self.waiting_for(user)
    Friendship.where(accepted: false, friend_id: user.id)
  end

  def self.friend_for(user)
    Friendship.where(friend_id: user.id).or(Friendship.where(user_id: user.id)).merge(Friendship.only_accepted).uniq
  end

  private

  def set_accepted
    self.accepted = !!accepted
  end
end
