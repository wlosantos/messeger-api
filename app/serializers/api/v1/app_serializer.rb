module Api
  module V1
    class AppSerializer < ActiveModel::Serializer
      attributes :id, :name, :app_id
    end
  end
end
