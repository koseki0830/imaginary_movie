# frozen_string_literal: true

module ApplicationHelper
  # フラッシュメッセージのcssクラス
  def message_type_to_css_class(message_type)
    case message_type
    when 'notice'
      'bg-blue-100 border border-blue-500 text-blue-700 px-4 py-3 rounded'
    when 'alert'
      'bg-red-100 border border-red-500 text-red-700 px-4 py-3 rounded'
    end
  end

  def page_title(page_title = '')
    base_title = '虚構映画'

    page_title.empty? ? base_title : page_title + " | " + base_title
  end
end
