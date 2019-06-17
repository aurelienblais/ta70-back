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
end
