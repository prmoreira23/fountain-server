class JobOpeningsController < ApplicationController
  before_action :authorize_request, except: %i(index latest_jobs show)
  before_action :set_user, only: %i(index latest_jobs)
  before_action :find_job_opening, except: %i(create index latest_jobs)
  before_action only: %i(update) do |ctrl|
    ctrl.ensure_user_owns_record(@job_opening)
  end

  def index
    render json: JSONAPI::Serializer.serialize(job_openings.page(params[:page] || 1),
      meta: { count: job_openings.count }, is_collection: true, context: { user: @current_user }), status: :ok
  end

  def latest_jobs
    render json: JSONAPI::Serializer.serialize(job_openings.first(9), is_collection: true,
      context: { user: @current_user }), status: :ok
  end

  def show
    render json: JSONAPI::Serializer.serialize(@job_opening), status: :ok
  end

  def create
    @job_opening = JobOpening.new(job_opening_params)
    @job_opening.user = @current_user
    status = @job_opening.save ? :created : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@job_opening), status: status
  end

  def update
    status = @job_opening.update(job_opening_params) ? :ok : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@job_opening), status: status
  end

  def apply_to_job
    job_application = Application.new(user: @current_user, job_opening: @job_opening)
    status = job_application.save ? :created : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@job_opening, context: { user: @current_user }), status: status
  end

  private
  def find_job_opening
    @job_opening = JobOpening.find(job_opening_params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Job opening not found' }, status: :not_found
  end

  def job_openings
    @job_openings ||= @current_user.try(:employer?) ? @current_user.job_openings : JobOpening.all
    @job_openings.order(id: :desc).includes(:user)
  end

  def job_opening_params
    params.permit(:id, :title, :description)
  end
end
