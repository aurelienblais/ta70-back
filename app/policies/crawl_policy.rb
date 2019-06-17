# frozen_string_literal: true

class CrawlPolicy < ApplicationPolicy
  def update?
    record.user == user || user.admin?
  end

  def destroy?
    update?
  end
end
