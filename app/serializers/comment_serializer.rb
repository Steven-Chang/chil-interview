# frozen_string_literal: true

class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :body

  belongs_to :author, serializer: UserSerializer
end
