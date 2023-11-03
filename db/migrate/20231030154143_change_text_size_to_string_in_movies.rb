class ChangeTextSizeToStringInMovies < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :text_size, :string
  end
end
