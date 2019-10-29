class Api::V1::UsersController < ApplicationController
  respond_to :json

  def create
    user = User.new(user_params)
    # render json: user, status: 201 if user.save
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def show
    user = User.find(params[:id])
    respond_with user
  rescue StandardError
    head 404
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
