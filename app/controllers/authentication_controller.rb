class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  api :POST, '/auth/login',"User Login"
  param :email, String , desc: "Email of user", required: true
  param :password, String , desc: "Password of user", required: true
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  api :POST,'/auth/logout', "User Logout"
  def logout
    auth_token = nil
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end