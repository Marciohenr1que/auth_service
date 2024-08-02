class RegistrationsController < ApplicationController
    def create
      service = UserRegistrationService.new(user_params)
      result = service.call
  
      if result[:success]
        render json: UserSerializer.new(result[:user]).as_json, status: :created
      else
        render json: { errors: result[:errors] }, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  