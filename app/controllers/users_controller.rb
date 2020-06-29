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
    render json: user.applications, include: [:position => {:only => [:id, :title]}]
  end

  def positions
    user = User.find(params[:id])
    if user.is_company
      render json: user.company.positions
    else
      render json: {error: "User has no company"}
    end
  end

  def company
    user = User.find(params[:id])
    if user.is_company
      render json: user.company
    else
      render json: {error: "User has no company"}
    end
  end


  def messages
    user = User.find(params[:id])
    if user.is_company
      render json: user.company.messages
    else
      render json: user.messages
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
