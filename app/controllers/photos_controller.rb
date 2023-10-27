class PhotosController < ApplicationController
  def index
    if params[:query].present?
      client = PexelsClient.new
      @photos = client.search_photos(params[:query])
    end
  end
end