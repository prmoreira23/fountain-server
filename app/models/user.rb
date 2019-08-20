class User < ApplicationRecord
  has_secure_password
  enum role: [:applicant, :employer]
  has_many :applications

  after_initialize :set_default_role, :if => :new_record?

  private
  def set_default_role
    self.role ||= :applicant
  end
end
