class AuthenticationTokenService
    HMAC_SECRET = 'my$ecretK3y'
    ALGORTIM_TYPE = 'HS256'
    def self.encode(user_id)
        payload = {user_id: user_id}
        JWT.encode payload, HMAC_SECRET, ALGORTIM_TYPE
    end
    def self.decode(token)
        decode = JWT.decode token, HMAC_SECRET, true, {algorithm:ALGORTIM_TYPE}
        decode[0]['user_id']
    end
end