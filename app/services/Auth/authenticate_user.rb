module Auth
    class AuthenticateUser < BaseService
        def initialize(auth_fields)
          @email = auth_fields[:email]
          @password = auth_fields[:password]
        end
        def call
            Jwt::JsonWebToken.encode({user_id: user.id}) if user
        end

        private

        def user
            user = User.find_by_email(@email)
            return user if user && user.authenticate(@password)
            raise Exceptions::UnauthorizedOperation.message("Check Email or password")
        end

    end
end