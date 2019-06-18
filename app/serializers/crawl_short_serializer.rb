# frozen_string_literal: true

class CrawlShortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description

  attributes :is_owner do |crawl, params|
    params[:current_user] == crawl.user
  end
end
