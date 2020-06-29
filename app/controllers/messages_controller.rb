class MessagesController < ApplicationController
  def show
    message = Message.find(params[:id])
    render json: message, include: [:company, :user, :position => {:only => [:id, :title]}]
  end
end
