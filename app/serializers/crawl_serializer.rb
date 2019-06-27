# frozen_string_literal: true

class CrawlSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :event_date, :status

  attributes :owner do |crawl|
    {
      id: crawl.user_id,
      name: crawl.user.name
    }
  end

  attributes :is_owner do |crawl, params|
    params[:current_user] == crawl.user
  end

  attributes :pois do |crawl|
    PoiShortSerializer.new(crawl.pois).as_json
  end

  attributes :users do |crawl|
    CrawlUserSerializer.new(crawl.crawl_users).as_json
  end
end
