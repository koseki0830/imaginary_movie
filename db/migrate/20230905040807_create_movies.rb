# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.text :synopsis, null: false
      t.string :thumbnail
      t.integer :screening_time, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
