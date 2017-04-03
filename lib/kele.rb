require 'httparty'

class Kele
  include HTTParty
  BASE_URI = 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    @email = email
    @password = password
  end

  def get_me
    options = { body: { email: @email, password: @password } }
    response = self.class.post(BASE_URI + '/sessions', options)
    @auth_token = response['auth_token']
  end

end
