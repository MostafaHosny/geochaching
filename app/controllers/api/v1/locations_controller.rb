class Api::V1::LocationsController < ApplicationController

before_action :location_params, only: [:create]
  # before_action :set_location, only: [:nearby , :closest ]
  
  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location , status: :created
    else
      render json: @location.errors, status: :bad_request
    end
  end

  def nearby
    @locations = @location.nearby
  end

  def closest
    @location = @location.closest
    render json: @location, status: :ok
  end


  private
  def location_params
    params.require(:location).permit(:lat, :lng , message_attributes: [:content])
  end

  def set_location
    @location = Location.new(lat:
      params[:lat] , lng: params[:lng])
  end
end
