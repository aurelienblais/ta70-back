# frozen_string_literal: true

class CreateMenuItem < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.text :description
      t.float :price

      t.references :poi

      t.timestamps
    end
  end
end
