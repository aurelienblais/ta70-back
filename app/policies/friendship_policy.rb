# frozen_string_literal: true

class FriendshipPolicy < ApplicationPolicy
  def update?
    user == record.friend
  end

  def destroy?
    user == record.user || user == record.friend
  end
end
