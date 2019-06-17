# frozen_string_literal: true

class PoisController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    render json: PoiShortSerializer.new(Poi.all).serialized_json
  end

end