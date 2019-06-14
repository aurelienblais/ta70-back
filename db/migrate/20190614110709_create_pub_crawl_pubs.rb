# frozen_string_literal: true

class CreatePubCrawlPubs < ActiveRecord::Migration[5.2]
  def change
    create_table :pub_crawl_pubs do |t|
      t.references :pub
      t.references :pub_crawl
    end
  end
end
