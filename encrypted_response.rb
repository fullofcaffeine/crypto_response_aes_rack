require './aes_crypt'
require 'digest/md5'
require 'base64'

DUMMY_KEY = Digest::MD5.hexdigest('shared_user_id').to_s

class EncryptedResponse
  def initialize(app)
    @app = app
  end

  def call(env)
    #We might add filters here, like ONLY encryting for certain parts or MIME response types
    status, headers, body = @app.call(env)

    body = [Base64.encode64(AESCrypt.encrypt(body.join, DUMMY_KEY))]

    headers["Content-Length"] = body[0].bytesize

    [status, headers, body]
  end
end
