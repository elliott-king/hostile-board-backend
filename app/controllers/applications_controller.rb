class ApplicationsController < ApplicationController
  def create
    a = Application.create!(application_params)
    render json: a
  end

  private
  def application_params
    params.require(:application).permit(
      :user_id, :position_id, :job_history, :projects, :written_introduction, skills: [])
  end
end
