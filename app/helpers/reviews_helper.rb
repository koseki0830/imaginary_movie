module ReviewsHelper
  def getPercent(number) 
    if number.present?
      calPercent = number/5.to_f * 100
      percent = calPercent.round
      #CSSは小数が含まれると、widthの幅を指定できないので四捨五入して整数化
      return percent.to_s
    else
      return 0
    end
  end
end