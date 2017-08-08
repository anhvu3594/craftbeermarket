module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # identified_by :current_user
    #
    # def connect
    #   self.current_user = find_verified_user
    # end
    #
    # private
    #   def find_verified_user
    #     token = Token.find_by(access_token: params[:token])
    #     if token && !token.expired?
    #       User.find(token.user_id)
    #     else
    #       error!('Unauthorized. Invalid or expired token.', 401)
    #     end
    #   end
    
  end
end
