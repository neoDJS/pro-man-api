class SessionSerializer < ActiveModel::Serializer
  attributes :api_token
  belongs_to :user
end
