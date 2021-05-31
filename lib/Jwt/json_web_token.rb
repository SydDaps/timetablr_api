module Jwt
    class JsonWebToken
        def self.encode(payload, exp =  24.hours.from_now)
            payload[:exp] = exp.to_i
            JWT.encode(payload, ENV['TIMETABLR_API_SECRETE'])
        end

        def self.decode(token)
            begin
                body = JWT.decode(token, ENV['TIMETABLR_API_SECRETE']).first
                HashWithIndifferentAccess.new body
            rescue 
                return
            end
        end
    end
end