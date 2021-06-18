class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request

  def create
    response = UserService::Register.call(params)
    
    
    render json: {
      success: true,
      code: 200,
      data: {
        access_token: response[:token],
        user: UserSerializer.new(response[:user]).serialize
      }
    }
  end
end
