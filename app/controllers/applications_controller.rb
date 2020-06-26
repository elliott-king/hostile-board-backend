class ApplicationsController < ApplicationController
  def create
    print(application_params)
    app = application_params
    # FIXME: need a user id from the frontend
    app[:user_id] = User.first.id
    a = Application.create!(app)
    render json: a
  end

  private
  def application_params
    params.require(:application).permit(
      :position_id, :skills, :job_history, :projects, :written_introduction)
  end
end
