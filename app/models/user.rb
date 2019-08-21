class User < ApplicationRecord
  has_secure_password
  enum role: [:applicant, :employer]

  MethodNotSupportedToEmployer = Class.new(StandardError)
  MethodNotSupportedToApplicant = Class.new(StandardError)

  has_many :applications
  has_many :job_openings

  validates_presence_of :name, :email, :role
  validates_uniqueness_of :email

  after_initialize :set_default_role, :if => :new_record?

  def applications
    raise MethodNotSupportedToEmployer unless self.applicant?
    super
  end

  def job_openings
    raise MethodNotSupportedToApplicant unless self.employer?
    super
  end

  private
  def set_default_role
    self.role ||= :applicant
  end
end
