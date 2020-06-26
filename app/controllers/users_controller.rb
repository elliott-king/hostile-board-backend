class UsersController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user 
      render json: {error: "email already taken"}
    else
      render json: User.create(user_params)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
