# frozen_string_literal: true

class PubUser < ApplicationRecord
  belongs_to :user
  belongs_to :pub
end
