# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :note

      t.references :user
      t.references :comment_thread

      t.timestamps
    end
  end
end
