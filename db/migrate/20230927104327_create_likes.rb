# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true

      t.timestamps
      t.index %i[user_id review_id], unique: true
    end
  end
end
