class Api::V1::TokenController < ApplicationController
  skip_before_action :authenticate_request

  def create
    token = Auth::AuthenticateUser.call(params)

    render json: {
      success: true,
      code: 200,
      data: {
        access_token: token
      }
    }
  end
end
