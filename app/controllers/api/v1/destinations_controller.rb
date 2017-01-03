class Api::V1::DestinationsController < ApplicationController
  def index
    render json: Destination.all
  end

  def show
    render json: Destination.find(params[:id])
  end

  def create
    destination = Destination.new(destination_params)
    if destination.save
      render json: destination
    else
      render json: { message: "Failed to create destination."}
    end
  end

  def update
    destination = Destination.find(params[:id])
    if destination.update(destination_params)
      render json: destination
    else
      render json: { message: "Failed to update destination."}
    end
  end

  def destroy
    destination = Destination.find(params[:id])
    destination.destroy
  end

  private

  def destination_params
    params.require(:destination).permit(:name, :zip, :description, :image_url)
  end
end
