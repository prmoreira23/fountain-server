class JobApplicationsController < ApplicationController
  before_action :authorize_request, except: %i(index latest_jobs show)
  before_action :set_user, only: %i(index)

  def index
    render json: JSONAPI::Serializer.serialize(job_applications.page(params[:page] || 1),
      meta: { count: job_applications.count }, is_collection: true, context: { user: @current_user }), status: :ok
  end

  private
  def job_applications
    @job_applications ||= @current_user.try(:employer?) ? @current_user.job_applications : @current_user.applications
    @job_applications.order(id: :desc).includes(:user)
  end
end
