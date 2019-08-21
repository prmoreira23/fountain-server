class JobOpening < ApplicationRecord
  belongs_to :user, class_name: "User"
  validate :ensure_user_is_employer

  validates_presence_of :title, :description, :user

  private
  def ensure_user_is_employer
    errors.add(:user, "must be an employer to be able to create job openings") unless user.employer?
  end
end
