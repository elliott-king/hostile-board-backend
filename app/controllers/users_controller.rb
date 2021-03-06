require 'securerandom'

class UsersController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user 
      render json: {error: "email already taken"}, status: 400
    else
      resume = params[:pdf]
      params = user_params.except(:pdf)
      user = User.create!(params)
      user.resume.attach(resume) if resume.present? && !!user
      render json: user.as_json(root: false, methods: :resume_url).except('updated_at')
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def applications
    user = User.find(params[:id])
    if !user.is_company
      render json: user.applications, include: [:position => {:only => [:id, :title, :city], include: [:company]}]
    else
      render json: user.company.applications, include: [:user, :position => {:only => [:id, :title, :city]}]
    end
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
    params.permit(:email, :first_name, :last_name, :pdf)
  end

  def parse_resume(filepath)
    # https://stackoverflow.com/questions/18645352/call-python-script-from-ruby
    parser_runner = "/Users/mymac/Documents/workspaces/learn/hostile-board-backend/parser_runner.py"
    resume = `python3 #{parser_runner} '#{filepath}'`
    print(resume)
    return resume
  end
end
