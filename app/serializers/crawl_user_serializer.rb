# frozen_string_literal: true

class CrawlUserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name do |crawl_user|
    {
      id: crawl_user.user.id,
      name: crawl_user.user.name
    }
  end
end
