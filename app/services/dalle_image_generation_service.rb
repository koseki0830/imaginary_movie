require 'httparty'

class DalleImageGenerationService

  BASE_URL = "https://api.openai.com/v1/images/generations"

  def self.generate_image(prompt)
    headers = {
      "Authorization" => "Bearer #{ENV['API_KEY']}",
      "Content-Type" => "application/json"
    }

    body = {
      "prompt" => prompt,
      "n" => 1, 
      "size" => "512x512"
    }.to_json
    
    begin
      response = HTTParty.post(BASE_URL, headers: headers, body: body, timeout: 10) # 10秒タイムアウト
      
      if response.success?
        return response["data"][0]["image_url"] # 仮のレスポンス構造（実際のAPIのレスポンス構造に合わせて変更する必要があります）
      else
        Rails.logger.error("Error generating image: #{response.body}")
        return nil
      end
    rescue HTTParty::Error => e
      Rails.logger.error("HTTParty error: #{e.message}")
      return nil
    rescue StandardError => e
      Rails.logger.error("Unknown error: #{e.message}")
      return nil
    end
  end
end