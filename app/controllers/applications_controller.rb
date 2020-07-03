class ApplicationsController < ApplicationController

  def index
    render json: Application.all, include: [:user, :position => {:only => [:id, :title, :city]}]
  end

  def create
    a = Application.create!(application_params)
    render json: a
  end

  def show
    a = Application.find(params[:id])
    render json: a, include: [:user, :position => {:only => [:id, :title, :city]}]
  end

  def messages
    a = Application.find(params[:id])
    p = a.position
    u = a.user
    messages = Message.where(position: p, user: u)
    render json: messages, include: [:company, :user, :position => {:only => [:id, :title, :city]}]
  end

  private
  def application_params
    params.require(:application).permit(
      :user_id, :position_id, :job_history, :projects, :written_introduction, skills: [])
  end
end
