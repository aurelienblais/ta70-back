# frozen_string_literal: true

class CreatePubUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :pub_users do |t|
      t.belongs_to :pub
      t.belongs_to :user

      t.boolean :accepted

      t.timestamps
    end
  end
end
