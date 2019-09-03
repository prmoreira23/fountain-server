class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job_opening

  paginates_per 9

  validate :ensure_user_is_applicant, :ensure_user_has_not_applied_to_job_already

  private
  def ensure_user_is_applicant
    unless user.applicant?
      errors.add(:user, "must be an applicant to be able to apply to job openings")
    end
  end

  def ensure_user_has_not_applied_to_job_already
    if job_opening.has_user_already_applied?(user)
      errors.add(:user, "you already applied to this job opening")
    end
  end
end
