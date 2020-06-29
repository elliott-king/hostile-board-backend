class UsersController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user 
      render json: {error: "email already taken"}
    else
      render json: User.create(user_params)
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def applications
    user = User.find(params[:id])
    render json: user.applications
  end

  def positions
    user = User.find(params[:id])
    if !user.company
      render json: {error: "User has no company"}
    else
      render json: user.company.positions
    end
  end

  def company
    user = User.find(params[:id])
    render json: user.company
  end

  # TODO: messages

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
