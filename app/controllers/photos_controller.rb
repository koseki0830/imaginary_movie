# frozen_string_literal: true

class PhotosController < ApplicationController
  def index
    if params[:query].present?
      client = PexelsClient.new
      @photos = client.search_photos(params[:query])
      @searched = params[:query].present?
    end
  end
end
