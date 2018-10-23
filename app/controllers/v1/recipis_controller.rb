class V1::RecipisController < ApplicationController
  before_action :is_recipe_owner, only: %i[update destroy]
  before_action :paginate_per_page, only: %i[index]

  def index
    recipi = Recipi.all.paginate(page: params[:page], per_page: @per_page)
    if recipi
      render json: recipi, status: :ok
    else
      render json: recipi.errors
    end
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
    recipi = Recipi.find(params[:id])
    if recipi
      render json: recipi
    else
      render json: recipi.errors, status: :bad
    end
  end

  def destroy
    @recipi.destroy if @recipi
  end

  def update
    @recipi.update!(recipi_params)
    @recipi.image.attach(params[:image])
    render json: @recipi
  end

  private
  def recipi_params
    params.permit(:name, :image, :preparation_description, :owner_id, ingredients: [])
  end

  def paginate_per_page
    @per_page = params.key?(:per_page) ? params[:per_page] : 12
  end

  def is_recipe_owner
    @recipi = Recipi.find(params[:id])
    if @recipi.owner != @current_user
      raise(
        ExceptionHandler::AuthenticationError, "You don't have permission for that action"
      )
    end
  rescue ActiveRecord::RecordNotFound
  end
end
