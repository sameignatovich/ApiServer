class ActiveJWT
  class << self
    def encode(payload)
      data = { data: payload }
      JWT.encode data, Rails.application.credentials.secret_jwt!, 'HS512'
    end

    def decode(jwt)
      decoded_data = JWT.decode(jwt, Rails.application.credentials.secret_jwt!, true, algorithm: 'HS512')
      return decoded_data[0]['data']
    rescue
      nil
    end
  end
end