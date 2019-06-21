# frozen_string_literal: true

class PoiCrawlsController < ApplicationController
  api :GET, '/crawls/:crawl_id/poi_crawls'
  returns code: 200, desc: 'List all poi from the crawl' do
    property :data, Hash do
      property :id, :number, desc: 'data id'
      property :type, String, desc: 'type of the data'
      property :relationships, Hash do
        property :poi, Hash do
          property :data, Hash do
            property :id, :number, desc: 'poi id'
            property :type, :number, desc: 'data type'
          end
        end
      end
    end
    property :included, Array, desc: 'Number of the poi' do
      property :id, :number, desc: 'poi id'
      property :type, String, desc: 'data type'
      property :attributes, Hash do
        property :name, String, desc: 'attribute name'
        property :address, String, desc: 'attribute address'
        property :phone, String, desc: 'attribute phone number'
        property :description, String, desc: 'attribute description'
        property :lat, :number, desc: 'attribute latitude'
        property :lng, :number, desc: 'attribute longitude'
        property :parsed_opening_hours, Array do
          property :weekday, Array, desc: 'Number of the day (0..6)' do
            property :opening, String, desc: 'Opening time'
            property :closing, String, desc: 'Closing time'
          end
        end
        property :menu_items, Array, desc: 'items from the poi menu'
        property :events, Array, desc: 'events from the poi'
        property :comment_thread, Array, desc: 'associated comment thread with note average'
      end
    end
  end

  def index
    @crawl = Crawl.eager_load(:poi_crawls).find params[:crawl_id]
    authorize @crawl, policy_class: PoiCrawlPolicy
    render json: PoiCrawlSerializer.new(@crawl.poi_crawls, include: [:poi]).serialized_json
  end

  api :POST, '/crawls/:crawl_id/poi_crawls/:id'
  param :poi_craw, Hash do
    param :poi_id, :number, desc: 'id of the POI to add at this crawl', required: true
  end
  returns code: 200, desc: 'Object has been created'
  returns code: [400, 401], desc: 'raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def create
    @crawl = Crawl.find params[:crawl_id]
    authorize @crawl, policy_class: PoiCrawlPolicy
    @poi_crawl = PoiCrawl.create! poi_crawl_params.merge(crawl: @crawl)
    head :ok
  end

  api :DELETE, '/crawls/:crawl_id/poi_crawls/:id'
  returns code: 200, desc: 'Object has been deleted'
  returns code: [401, 403, 404], desc: 'Raised if an error occured' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def destroy
    @poi_crawl = PoiCrawl.eager_load(:crawl).find params[:id]
    authorize @poi_crawl.crawl, policy_class: PoiCrawlPolicy
    @poi_crawl.destroy!
    head :ok
  end

  private

  def poi_crawl_params
    params.require(:poi_crawl).permit(
      :poi_id,
      :crawl_id
    )
  end
end
