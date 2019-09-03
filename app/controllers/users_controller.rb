class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action only: :update do |ctrl|
    ctrl.ensure_user_owns_record(@user)
  end

  def show
    render json: JSONAPI::Serializer.serialize(@current_user), status: :ok
  end

  def create
    @user = User.new(user_params)
    status = @user.save ? :created : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@user), status: status
  end

  def update
    status = @user.update(user_params) ? :ok : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@current_user), status: status
  end

  private
  def user_params
    params.permit(:id, :name, :email, :role, :password, :password_confirmation)
  end
end
