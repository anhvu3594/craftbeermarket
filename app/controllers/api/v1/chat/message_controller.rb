module API
  module V1
    module Chat
      class MessageController < Grape::API
        include API::V1::Defaults

        resource :message do
          # before do
          #   authenticate!
          # end
          desc 'Send message'
        end
      end
    end
  end
end
