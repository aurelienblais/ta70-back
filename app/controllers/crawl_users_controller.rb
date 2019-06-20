# frozen_string_literal: true

class CrawlUsersController < ApplicationController
  api :POST, '/crawls/:crawl_id/crawl_users/:id'
  param :craw_user, Hash do
    param :user_id, :number, desc: 'id of the user to add at this crawl', required: true
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
    authorize @crawl, policy_class: CrawlUserPolicy
    @crawl_users = CrawlUser.create! crawl_user_params.merge(crawl: @crawl)
    head :ok
  end

  api :PATCH, '/crawls/:crawl_id/crawl_users/:id'
  param :craw_user, Hash do
    param :user_id, :number, desc: 'id of the user to add at this crawl', required: true
  end
  returns code: 200, desc: 'Object has been created'
  returns code: [401, 403], desc: 'raised if a params is missing' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def update
    @crawl_user = CrawlUser.find params[:id]
    authorize @crawl_user, policy_class: CrawlUserPolicy
    @crawl_user.update! crawl_user_params
    head :ok
  end

  api :DELETE, '/crawls/:crawl_id/crawl_users/:id'
  returns code: 200, desc: 'Object has been deleted'
  returns code: [401, 403, 404], desc: 'Raised if an error occurred' do
    property :errors, Hash, desc: 'Error details' do
      property :status, String, desc: 'Error code'
      property :title, String, desc: 'Error title'
      property :detail, Hash, desc: 'Error per field'
    end
  end

  def destroy
    @crawl_user = CrawlUser.eager_load(:crawl).find params[:id]
    authorize @crawl_user, policy_class: CrawlUserPolicy
    @crawl_user.destroy!
    head :ok
  end

  private

  def crawl_user_params
    params.require(:crawl_user).permit(
      :user_id,
      :accepted
    )
  end
end
