# frozen_string_literal: true

class PoisController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  api :GET, '/pois'
  param :lat, String, required: true, desc: 'User position latitude'
  param :lng, String, required: true, desc: 'User position longitude'
  param :family, String, desc: 'Type of POI, default to `bar`'
  returns code: 200 do
    property :id, :number, desc: 'POI id'
    property :attributes, Hash do
      property :name, String, desc: 'POI name'
      property :lat, :number, desc: 'POI latitude'
      property :lng, :number, desc: 'POI longitude'
    end
  end
  returns code: 400, desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def index
    render json: PoiShortSerializer.new(Poi.where(family: params[:family] || 'bar').near([params[:lat], params[:lng]], 2, unit: :km)).serialized_json
  end

  api :GET, '/pois/:id', 'Return a single object'
  param :id, :number, 'Id of the object', required: true
  returns code: 200 do
    property :id, :number, desc: 'POI id'
    property :attributes, Hash do
      property :name, String, desc: 'POI name'
      property :address, String, desc: 'POI address'
      property :phone, String, desc: 'POI phone number'
      property :description, String, desc: 'POI description'
      property :lat, :number, desc: 'POI latitude'
      property :lng, :number, desc: 'POI longitude'

      property :parsed_opening_hours, Array do
        property :weekday, Array, desc: 'Number of the day (0..6)' do
          property :opening, String, desc: 'Opening time'
          property :closing, String, desc: 'Closing time'
        end
      end

      property :menu_items, Array do
        property :name, String, desc: 'Item name'
        property :description, String, desc: 'Item description'
        property :price, :number, desc: 'Item price'
      end

      property :events, Array do
        property :name, String, desc: 'Event name'
        property :description, String, desc: 'Event description'
        property :event_date, String, desc: 'Event date'
      end
    end
  end
  returns code: 404, desc: 'Object not found' do
    property :status, :number, desc: 'Error code'
    property :title, String
    property :detail, String
  end

  def show
    render json: PoiSerializer.new(
      Poi.eager_load(:opening_hours, :events, :menu_items)
          .merge(OpeningHour.order_by_weekday)
          .merge(Event.only_upcoming.order_by_date)
          .find(params[:id])
    ).serializable_hash
  rescue ActiveRecord::RecordNotFound
    render json: { errors: { status: 404, title: 'Not found', detail: "Object with id #{params[:id]} not found" } }, status: :not_found
  end
end
