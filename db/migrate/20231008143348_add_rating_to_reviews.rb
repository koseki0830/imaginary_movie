# frozen_string_literal: true

class AddRatingToReviews < ActiveRecord::Migration[7.0]
  def up
    add_column :reviews, :rating, :integer, null: false, default: 0
  end

  def down
    remove_column :reviews, :rating, :integer
  end
end
