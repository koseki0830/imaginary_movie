# frozen_string_literal: true

class PhotosController < ApplicationController
  def index
    return unless params[:query].present?

    client = PexelsClient.new
    @photos = client.search_photos(params[:query])
    @searched = true
  end
end
