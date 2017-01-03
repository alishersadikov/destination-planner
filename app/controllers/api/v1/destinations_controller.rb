class Api::V1::DestinationsController < ApplicationController
  def index
    render json: Destination.all
  end

  def show
    render json: Destination.find(params[:id])
  end

  def new
    @destination = Destination.new
  end

  def create
    destination = Destination.new(destination_params)
    if destination.save
      render json: destination
    else
      render json: { message: "Failed to create destination."}
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :zip, :description, :image_url)
  end
end
