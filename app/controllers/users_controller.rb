class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, except: :create

  def show
    render json: JSONAPI::Serializer.serialize(@user), status: :ok
  end

  def create
    @user = User.new(user_params)
    status = @user.save ? :created : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@user), status: status
  end

  def update
    status = @user.update(user_params) ? :ok : :unprocessable_entity
    render json: JSONAPI::Serializer.serialize(@user), status: status
  end

  private
  def find_user
    @user = User.find(user_params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:id, :name, :email, :role, :password, :password_confirmation)
  end
end
