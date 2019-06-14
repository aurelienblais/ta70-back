# frozen_string_literal: true

class CreatePubCrawlUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :pub_crawl_users do |t|
      t.references :pub
      t.references :user

      t.boolean :accepted

      t.timestamps
    end
  end
end
