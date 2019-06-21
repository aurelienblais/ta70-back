# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :poi

  scope :only_upcoming, -> { where('events.event_date > ?', DateTime.now) }
  scope :order_by_date, -> { order(:event_date) }
end
