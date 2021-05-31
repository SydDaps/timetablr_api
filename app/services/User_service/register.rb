module UserService
    class Register < BaseService
        def initialize(auth_fields)
          @email = auth_fields[:email]
          @name = auth_fields[:name]
          @password = auth_fields[:password]
          @password_confirmation  = auth_fields[:password_confirmation]
        end

        def call
            user = User.find_by_email(@email)
            raise Exceptions::NotUniqueRecord.message("User with email #{@email} already registered") if user
            user = User.create!(
                email: @email,
                name: @name,
                password: @password,
                password_confirmation: @password_confirmation
            )

            Jwt::JsonWebToken.encode({user_id: user.id})
        end
    end
end