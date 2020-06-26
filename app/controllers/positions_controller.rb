class PositionsController < ApplicationController
  def index
    render json: Position.all, except: [:description]
  end

  def show
    position = Position.find_by(id: params[:id])
    if position
      render json: position
    else
      raise ActionController::RoutingError.new('Position not Found')
    end
  end
end
