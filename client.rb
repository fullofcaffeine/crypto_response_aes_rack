require 'faraday'
require './aes_crypt'
require 'base64'
require 'byebug'


#For debugging purposes. Set to false to output the encrypted base64 string
DECRYPT = true

# Our shared user id key.
DUMMY_KEY = Digest::MD5.hexdigest('shared_user_id').to_s

conn = Faraday.new(url: 'http://localhost:4567')  do |faraday|
  faraday.request :url_encoded
  faraday.response :logger
  faraday.adapter Faraday.default_adapter #Net::HTTP
end

#encrypted endpoint
resp = conn.get do |req|
  req.url "api/v1/foobar"
end

if DECRYPT
  puts AESCrypt.decrypt(Base64.decode64(resp.body), DUMMY_KEY)
else
  puts resp.body
end
