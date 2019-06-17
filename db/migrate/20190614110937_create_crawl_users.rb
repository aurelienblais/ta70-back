# frozen_string_literal: true

class CreateCrawlUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :crawl_users do |t|
      t.references :crawl
      t.references :user

      t.boolean :accepted

      t.timestamps
    end
  end
end
