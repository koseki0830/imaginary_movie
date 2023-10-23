class ThumbnailsController < ApplicationController
  def create
    prompt = params[:prompt]
    image_data = DalleImageGenerationService.generate_image(prompt)
    render json: { image_data: image_data }
  end
end
