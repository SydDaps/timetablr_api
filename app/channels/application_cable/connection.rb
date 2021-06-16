module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    include ErrorHandler

    def connect
      self.current_user = authorized_user
    end

    private
    
    def authorized_user
      token = request.params[:token]  
      
      unless token
        return reject_unauthorized_connection
      end

      user = Jwt::JsonWebToken.decode(token)
      
      return reject_unauthorized_connection  unless user 
      
      User.find(user[:user_id])
    end

  end
end
