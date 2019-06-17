# frozen_string_literal: true

class CreatePoiUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :poi_users do |t|
      t.belongs_to :poi
      t.belongs_to :user

      t.boolean :accepted

      t.timestamps
    end
  end
end
