class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if !user
      render json: {error: "User not found"}
    else
      render json: user
    end
  end
end