# frozen_string_literal: true

class OpeningHour < ApplicationRecord
  belongs_to :poi

  scope :order_by_weekday, -> { order(:weekday) }

  # Override opening and closing getter to return Time format
  def opening
    self[:opening]&.strftime '%H:%M'
  end

  def closing
    self[:closing]&.strftime '%H:%M'
  end
end
