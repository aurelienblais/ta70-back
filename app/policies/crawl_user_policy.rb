# frozen_string_literal: true

class CrawlUserPolicy < ApplicationPolicy
  def create?
    record.user == user || user.admin?
  end

  def update?
    record.user == user || user.admin?
  end

  def destroy?
    (record.crawl.user == user) || update?
  end
end
