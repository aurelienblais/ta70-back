# frozen_string_literal: true

class UserShortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
