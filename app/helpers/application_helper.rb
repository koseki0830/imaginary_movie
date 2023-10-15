module ApplicationHelper

  # フラッシュメッセージのcssクラス
  def message_type_to_css_class(message_type)
    case message_type
    when 'notice'
      "bg-blue-100 border border-blue-500 text-blue-700 px-4 py-3 rounded"
    when 'alert'
      'bg-red-100 border-t-4 border-red-500'
    else
      'bg-gray-100 border-t-4 border-gray-500' # デフォルト
    end
  end
end
