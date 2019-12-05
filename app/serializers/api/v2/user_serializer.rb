class Api::V2::UserSerializer < ActiveModel::Serializer
  attributes %i[id email auth_token created_at updated_at]
end
