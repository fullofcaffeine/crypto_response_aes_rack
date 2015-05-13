require 'openssl'

class AESCrypt

  #AES 128 bits key, CBC (Cypher-Block-Chaining) mode
  # Mode of operation: http://en.wikipedia.org/wiki/Block_cipher_mode_of_operation
  CIPHER_TYPE = "AES-128-CBC".freeze

  class << self

    def encrypt(data, key)
      aes = OpenSSL::Cipher::Cipher.new(CIPHER_TYPE)
      aes.encrypt
      aes.iv = iv = aes.random_iv

      aes.key = Digest::SHA512.hexdigest(key)

      #The iv is prepended, we can get it by slicing the first 16 bytes so
      #we're able to decrypt the ciphertext. See: http://en.wikipedia.org/wiki/Initialization_vector
      iv + aes.update(data) + aes.final
    end

    def decrypt(data, key)
      aes = OpenSSL::Cipher::Cipher.new(CIPHER_TYPE)
      aes.decrypt

      aes.iv = data.slice!(0, 16)

      aes.key = Digest::SHA512.hexdigest(key)

      aes.update(data) + aes.final
    rescue
      ""
    end
  end
end
