# frozen_string_literal: true

class CreatePoi < ActiveRecord::Migration[5.2]
  def change
    create_table :pois do |t|
      t.string :name
      t.string :address
      t.string :coordinates
      t.string :phone
      t.text :description

      t.string :family, default: :pub

      t.timestamps
    end
  end
end
