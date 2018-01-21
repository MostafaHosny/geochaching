class Api::V1::LocationsController < ApplicationController
  before_action :location_params, only: [:create]
  before_action :validate_params, only: [:nearby , :closest ]

  def create
    @location = Location.new(location_params)
    if @location.save
      render json: @location , status: :created
    else
      render json: @location.errors, status: :bad_request
    end
  end

  def nearby
    @locations = Location.includes(:message).nearby(params[:lat] , params[:lng])
    render json: @locations, status: :ok
  end

  def closest
    @location = Location.closest(params[:lat] ,params[:lng])
    render json: @location, status: :ok
  end


  private
    def location_params
      params.require(:location).permit(:lat, :lng , message_attributes: [:content])
    end

    def validate_params
      render json: {error:"Please enter a valid location"},
      status: :bad_request if (params[:lat].blank? || params[:lng].blank?) 
    end
end
