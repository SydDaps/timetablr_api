class Api::V1::TokenController < ApplicationController
  skip_before_action :authenticate_request

  def create
    token = Auth::AuthenticateUser.call(params)

    user = User.find(Jwt::JsonWebToken.decode(token)[:user_id])

  
    render json: {
      success: true,
      code: 200,
      data: {
        access_token: token,
        user: UserSerializer.new(user).serialize
      }
    }
  end
end
