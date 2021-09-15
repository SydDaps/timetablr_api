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
      

      if user[:user_id]
        User.find(user[:user_id])
      elsif user[:student_id]
        Student.find(user[:student_id])
      elsif user[:lecturer_id]
        Lecturer.find(user[:lecturer_id])
      end
    end

  end
end
