class AuthenticationController < ApplicationController
  def login
    result = UserAuthenticationService.call(auth_params[:email], auth_params[:password])

    if result[:success]
      render json: { token: result[:token], user: UserSerializer.new(result[:user]).as_json }, status: :ok
    else
      render json: { errors: result[:errors] }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
