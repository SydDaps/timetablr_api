module Auth
    class AuthorizeRequest < BaseService
        def initialize(headers = {})
          @headers = headers
        end

        def call
            user
        end

        private

        def user
            if decode_auth_token
                if decode_auth_token[:user_id]
                    @user ||= User.find(decode_auth_token[:user_id])
                elsif decode_auth_token[:student_id]
                    @user ||= Student.find(decode_auth_token[:student_id])
                elsif decode_auth_token[:lecturer_id]
                    @user ||= Lecturer.find(decode_auth_token[:lecturer_id])
                end
            end
            raise Exceptions::UnauthorizedOperation.message("User Not found") unless @user
            @user
        end

        def decode_auth_token
           @decoded_token ||= Jwt::JsonWebToken.decode(http_auth_header)
           raise Exceptions::ExpiredToken.message("Session Expired login again") unless @decoded_token
           @decoded_token
        end

        def http_auth_header
            if @headers.present?
                return @headers['HTTP_AUTHORIZATION'].split(' ').last
            end

            raise Exceptions::UnauthorizedOperation.message("Missing Token")
        end

    end
end