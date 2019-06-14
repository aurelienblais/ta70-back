# frozen_string_literal: true

class CreateOpeningHours < ActiveRecord::Migration[5.2]
  def change
    create_table :opening_hours do |t|
      t.integer :weekday, min: 0, max: 7
      t.time :opening
      t.time :closing

      t.references :pub
    end
  end
end
