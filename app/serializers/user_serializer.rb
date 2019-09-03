require 'jsonapi-serializers'

class UserSerializer < BaseSerializer
  attribute :name
  attribute :email
  attribute :role

  attribute :errors do
    object.errors.to_h
  end
end
