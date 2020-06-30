class MessagesController < ApplicationController
  def show
    message = Message.find(params[:id])
    render json: message, include: [:company, :user, :position => {:only => [:id, :title]}]
  end

  def create
    application = Application.find(params[:application_id])
    user = User.find(params[:user_id])
    position = application.position
    company = position.company
    m = Message.create!(
      user: user,
      position: position,
      company: company,
      content: params[:content],
    )
    render json: m, include: [:company, :user, :position => {:only => [:id, :title]}]
  end
end
