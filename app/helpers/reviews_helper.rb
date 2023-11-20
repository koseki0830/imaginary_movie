# frozen_string_literal: true

module ReviewsHelper
  def get_percent(number)
    if number.present?
      cal_percent = number / 5.to_f * 100
      percent = cal_percent.round
      # CSSは小数が含まれると、widthの幅を指定できないので四捨五入して整数化
      percent.to_s
    else
      0
    end
  end
end
