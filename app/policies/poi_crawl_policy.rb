# frozen_string_literal: true

class PoiCrawlPolicy < ApplicationPolicy
  def index?
    record.user == user || user.admin? # TODO: add friend
  end

  def create?
    record.user == user || user.admin?
  end

  def destroy?
    create?
  end
end
