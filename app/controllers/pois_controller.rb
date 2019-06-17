# frozen_string_literal: true

class PoisController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  api :GET, '/pois'
  param :lat, String, required: true, desc: 'User position latitude'
  param :lng, String, required: true, desc: 'User position longitude'

  returns code: 200 do
    property :id, :number, desc: 'POI id'
    property :type, String, desc: 'POI type'
    property :attributes, Hash do
      property :name, String, desc: 'POI name'
      property :lat, :number, desc: 'POI latitude'
      property :lng, :number, desc: 'POI longitude'
    end
  end

  def index
    render json: PoiShortSerializer.new(Poi.near([params[:lat], params[:lng]], 2, unit: :km)).serialized_json
  end
end
