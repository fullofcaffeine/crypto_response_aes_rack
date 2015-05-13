require 'sinatra'
require './encrypted_response'
require 'byebug'

configure do
  use EncryptedResponse
end

get '/api/v1/foobar' do
  "Nice"
end
