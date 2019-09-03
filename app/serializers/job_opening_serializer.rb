require 'jsonapi-serializers'

class JobOpeningSerializer < BaseSerializer
  attribute :title
  attribute :description

  attribute :employer do
    object.user.name
  end

  attribute :applied do
    has_user_applied
  end

  attribute :errors do
    object.errors.to_h
  end

  private
  def has_user_applied
    is_user_an_applicant? && object.has_user_already_applied?(user)
  end

  def is_user_an_applicant?
    user && user.applicant?
  end

  def user
    context[:user]
  end
end
