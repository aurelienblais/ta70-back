# frozen_string_literal: true

class CreateCommentThread < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_threads do |t|
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
