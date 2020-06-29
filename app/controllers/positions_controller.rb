class PositionsController < ApplicationController
  def index
    render json: Position.all, except: [:description], include: [:company => {:only => [:name, :company_logo, :id]}]
  end

  def show
    position = Position.find_by(id: params[:id])
    if position
      render json: position, include: [:company => {:only => [:name, :company_logo, :id]}]
    else
      raise ActionController::RoutingError.new('Position not Found')
    end
  end
end
