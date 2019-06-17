# frozen_string_literal: true

class HelloController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  # Allow ping on /
  def index
    head :ok
  end
end
