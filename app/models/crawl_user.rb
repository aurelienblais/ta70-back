# frozen_string_literal: true

class CrawlUser < ApplicationRecord
  belongs_to :user
  belongs_to :crawl

  before_save :set_accepted # TODO: fix that, front can't handle invitation so we force them

  private

  def set_accepted
    self.accepted = true
  end
end
