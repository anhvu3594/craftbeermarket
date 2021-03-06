module API
  module V2
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix 'api'
        version 'v2', using: :accept_version_header
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end

          # def logger
          #   Rails.logger
          # end

          def authenticate!
            error!('Unauthorized. Invalid or expired token.', 401) unless current_user
          end

          def current_user
            # find token. Check if valid.
            token = Token.find_by(access_token: params[:token])
            if token && !token.expired?
              @current_user = User.find(token.user_id)
            else
              false
            end
          end

          def authenticate_admin!
            authenticate!
            error!('You are not admin.', 401) unless @current_user.admin?
          end

          def collection_serializer
            ActiveModel::Serializer::CollectionSerializer
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end
