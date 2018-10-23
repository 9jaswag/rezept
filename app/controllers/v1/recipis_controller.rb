class V1::RecipisController < ApplicationController
  def index
  end

  def create
    recipi = Recipi.create!(recipi_params)
    if recipi
      render json: recipi, status: :created
    else
      render json: recipi.errors, status: :bad
    end
  end

  def show
  end

  def destroy
  end

  def update
  end

  private
  def recipi_params
    params.permit(:name, :image, :ingredients, :preparation_description, :owner_id)
  end
end
