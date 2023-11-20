# frozen_string_literal: true

module MoviesHelper
  def text_color_class(movie)
    colors = {
      '黒' => 'text-black',
      '白' => 'text-white',
      '赤' => 'text-rose-600',
      '青' => 'text-blue-600'
    }

    color = movie.text_color.presence || '黒'
    colors[color]
  end

  def text_size_class(movie)
    sizes = {
      '小' => 'text-base',
      '中' => 'text-lg',
      '大' => 'text-2xl'
    }

    size = movie.text_size.presence || '中'
    sizes[size]
  end

  def text_position_class(position)
    positions = {
      '上部' => 'items-start',
      '中部' => 'items-center',
      '下部' => 'items-end'
    }

    positions[position]
  end
end
