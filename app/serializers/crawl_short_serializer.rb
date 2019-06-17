# frozen_string_literal: true

class CrawlShortSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description

  attributes :owner do |crawl, params|
    params[:current_user] == crawl.user
  end
end
