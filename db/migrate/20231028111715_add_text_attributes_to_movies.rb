# frozen_string_literal: true

class AddTextAttributesToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :text_position, :string
    add_column :movies, :text_color, :string
    add_column :movies, :text_size, :integer
    add_column :movies, :font_type, :string
  end
end
