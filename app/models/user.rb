class User < ApplicationRecord
  has_secure_password
  enum role: [:applicant, :employer]

  MethodNotSupportedToEmployer = Class.new(StandardError)
  MethodNotSupportedToApplicant = Class.new(StandardError)

  has_many :applications
  has_many :job_openings
  has_many :job_applications, through: :job_openings, source: :applications

  validates_presence_of :name, :email, :role, :password, :password_confirmation
  validates_uniqueness_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid e-mail address" }, if: :email?

  after_initialize :set_default_role, :if => :new_record?

  def applications
    return Application.where(user_id: id) unless self.applicant?
    super
  end

  def job_openings
    raise MethodNotSupportedToApplicant unless self.employer?
    super
  end

  def job_applications
    raise MethodNotSupportedToApplicant unless self.employer?
    super
  end

  private
  def set_default_role
    self.role ||= :applicant
  end
end
