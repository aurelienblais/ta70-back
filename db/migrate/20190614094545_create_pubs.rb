# frozen_string_literal: true

class CreatePubs < ActiveRecord::Migration[5.2]
  def change
    create_table :pubs do |t|
      t.string :name
      t.string :address
      t.string :coordinates
      t.string :phone
      t.text :description

      t.timestamps
    end
  end
end
