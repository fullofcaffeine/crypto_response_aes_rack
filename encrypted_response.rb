require './aes_crypt'
require 'digest/md5'
require 'base64'

#Debugging purposes, in the real app, we will need to get the user id from Rails. We can
#do this at the Rack level by using env['warden'].user (Devise is based off Warden)

DUMMY_KEY = Digest::MD5.hexdigest('shared_user_id').to_s

class EncryptedResponse
  def initialize(app)
    @app = app
  end

  def call(env)
    #We might add filters here, like ONLY encryting for certain parts or MIME response types
    status, headers, response = @app.call(env)

    response = [Base64.encode64(AESCrypt.encrypt(response.join, DUMMY_KEY))]

    byebug

    [status, headers, response]
  end
end
