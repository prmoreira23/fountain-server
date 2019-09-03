require 'jsonapi-serializers'

class ApplicationSerializer < BaseSerializer
  attribute :applicant do
    object.user.name
  end
  
  attribute :title do
    object.job_opening.title
  end

  attribute :description do
    object.job_opening.description
  end

  attribute :employer do
    object.job_opening.user.name
  end
end
