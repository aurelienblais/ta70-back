# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    record.user == user || user.admin?
  end
end
