class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job_opening
end
