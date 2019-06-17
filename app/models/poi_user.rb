# frozen_string_literal: true

class PoiUser < ApplicationRecord
  belongs_to :user
  belongs_to :poi
end
