# frozen_string_literal: true

class CrawlsController < ApplicationController
  api :GET, '/crawls'
  returns code: 200, desc: 'List all crawls' do
    property :id, :number, desc: 'Crawl id'
    property :attributes, Hash do
      property :name, String, desc: 'Crawl name'
      property :description, String, desc: 'Crawl description'
      property :is_owner, :boolean, desc: 'Is crawl owned by current user'
    end
  end
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def index
    render json: CrawlShortSerializer.new(Crawl.all, params: { current_user: current_user }).serialized_json
  end

  api :GET, '/crawls/:id'
  returns code: 200, desc: 'Return crawl' do
    property :name, String, desc: 'Name of the crawl'
    property :description, String, desc: 'Description of the crawl'
    property :event_date, String, desc: 'Date of the crawl'
    property :status, String, desc: 'Status of the crawl'
    property :owner, Hash do
      property :id, :number, desc: 'Owner id'
      property :name, String, desc: 'Owner name'
    end
    property :is_owner, :boolean, desc: 'Is crawl owned by current user'
  end
  returns code: [401, 404], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def show
    render json: CrawlSerializer.new(Crawl.find(params[:id]), params: { current_user: current_user }).serializable_hash
  end

  api :POST, '/crawls'
  param :crawl, Hash do
    param :name, String, desc: 'Name of the crawl', required: true
    param :description, String, desc: 'Description of the crawl'
    param :event_date, String, desc: 'Date of the crawl'
    param :status, String, desc: 'Status of the crawl'
  end
  returns code: 200, desc: 'Return created crawl' do
    property :name, String, desc: 'Name of the crawl'
    property :description, String, desc: 'Description of the crawl'
    property :event_date, String, desc: 'Date of the crawl'
    property :status, String, desc: 'Status of the crawl'
    property :owner, Hash do
      property :id, :number, desc: 'Owner id'
      property :name, String, desc: 'Owner name'
    end
    property :is_owner, :boolean, desc: 'Is crawl owned by current user'
  end
  returns code: [400, 401], desc: 'Raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def create
    @crawl = Crawl.create! crawl_params.merge(user: current_user)
    render json: CrawlSerializer.new(@crawl, params: { current_user: current_user }).serializable_hash
  end

  api :PATCH, '/crawls/:id'
  param :crawl, Hash do
    param :name, String, desc: 'Name of the crawl'
    param :description, String, deslc: 'Description of the crawl'
    param :event_date, String, desc: 'Date of the crawl'
    param :status, String, desc: 'Status of the crawl'
  end
  returns code: 200, desc: 'Return updated crawl' do
    property :name, String, desc: 'Name of the crawl'
    property :description, String, desc: 'Description of the crawl'
    property :event_date, String, desc: 'Date of the crawl'
    property :status, String, desc: 'Status of the crawl'
    property :owner, Hash do
      property :id, :number, desc: 'Owner id'
      property :name, String, desc: 'Owner name'
    end
    property :is_owner, :boolean, desc: 'Is crawl owned by current user'
  end
  returns code: [400, 401, 403, 404], desc: 'Raised if an error occured' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def update
    @crawl = Crawl.eager_load(:user).find params[:id]
    authorize @crawl # Check if user own the crawl or is an admin
    @crawl.update! crawl_params
    render json: CrawlSerializer.new(@crawl, params: { current_user: current_user }).serializable_hash
  end

  api :DELETE, '/crawls/:id'
  returns code: 200, desc: 'Object has been deleted'
  returns code: [401, 403, 404], desc: 'Raised if an error occured' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def destroy
    @crawl = Crawl.find params[:id]
    authorize @crawl # Check if user own the crawl or is an admin
    @crawl.destroy!
    head :ok
  end

  private

  def crawl_params
    params.require(:crawl).permit(
      :name,
      :description,
      :event_date,
      :status
    )
  end
end
