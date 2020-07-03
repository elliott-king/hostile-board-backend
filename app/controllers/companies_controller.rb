class CompaniesController < ApplicationController
  def show
    render json: Company.find(params[:id]), include: [:positions => {:only => [:id, :title, :city]}]
  end
end
