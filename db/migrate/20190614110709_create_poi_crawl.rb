# frozen_string_literal: true

class CreatePoiCrawl < ActiveRecord::Migration[5.2]
  def change
    create_table :poi_crawls do |t|
      t.references :poi
      t.references :crawl
    end
  end
end
