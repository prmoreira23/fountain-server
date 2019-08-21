class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job_opening

  validate :ensure_user_is_applicant

  private
  def ensure_user_is_applicant
    errors.add(:user, "must be an applicant to be able to apply to job openings") unless user.applicant?
  end
end
