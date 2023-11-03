module MoviesHelper
  def text_color_class(movie)
    color = movie.text_color.presence || '黒'
    case color
    when '黒'
      'text-black'
    when '白'
      'text-white'
    when '赤'
      'text-rose-500'
    when '青'
      'text-blue-600'
    else
      'text-black' # デフォルト
    end
  end

  def text_size_class(movie)
    size = movie.text_size.presence || '中'
    case size
    when '小'
      'text-sm'
    when '中'
      'text-base'
    when '大'
      'text-xl'
    else
      'text-base' # デフォルト
    end
  end

  def text_position_class(position)
    case position
    when '上部'
      'items-start'
    when '中部'
      'items-center'
    when '下部'
      'items-end'
    end
  end
end