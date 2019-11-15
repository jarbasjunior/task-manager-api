class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user&.valid_password?(session_params[:password])
      sign_in user, store: false
      user.generate_authentication_token!
      user.save
      render json: user, status: 200
    else
      render json: { errors: 'Invalid password or e-mail'}, status: 401
    end
  end

  def destroy
    user = User.find_by(auth_token: params[:id])
    byebug
    user.generate_authentication_token!
    byebug
    user.save
    byebug
    head 204
    byebug
  end
  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
