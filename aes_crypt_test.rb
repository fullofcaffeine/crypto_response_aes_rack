require 'minitest/autorun'
require './aes_crypt'
require 'byebug'

class TestAesCrypt < Minitest::Test


  def setup
    @key = "supersecretmojo"
    @data = '{"foo":"bar"}'
  end

  def test_encrypt_returns_non_nil_string
    @encrypted_data = AESCrypt.encrypt(@data, @key)

    refute (@encrypted_data == nil)
  end

  def test_decrypts
    @encrypted_data = AESCrypt.encrypt(@data, @key)
    @decrypted_data = AESCrypt.decrypt(@encrypted_data, @key)

    assert_equal @decrypted_data, @data
  end
end
