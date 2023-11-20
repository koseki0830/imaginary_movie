# frozen_string_literal: true

require_dependency 'dalle_image_generation_service'

class ThumbnailsController < ApplicationController
  def new; end

  def create
    prompt = params[:prompt]
    @image_data = DalleImageGenerationService.generate_image(prompt)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to new_thumbnail_path }
    end
  end
end
