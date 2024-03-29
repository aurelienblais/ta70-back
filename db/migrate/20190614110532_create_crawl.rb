# frozen_string_literal: true

class CreateCrawl < ActiveRecord::Migration[5.2]
  def change
    create_table :crawls do |t|
      t.string :name
      t.text :description
      t.datetime :event_date
      t.string :status

      t.references :user

      t.timestamps
    end
  end
end
