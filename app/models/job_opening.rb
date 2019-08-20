class JobOpening < ApplicationRecord
  belongs_to :employer, class_name: "User"
end
