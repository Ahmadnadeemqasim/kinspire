require 'test_helper'

class CryptoTest < ActiveSupport::TestCase

  ##
  # .secure_digest

  test "function .secure_digest should return a hash resembling a bcrypt password digest" do
    string = "password"
    assert_equal 60, Crypto.secure_digest( string ).length, "Digest is not the expected length."
  end

  test "function .secure_digest should display random behavior" do
    string = "password"
    digest1 = Crypto.secure_digest( string )
    digest2 = Crypto.secure_digest( string )
    assert_not_equal digest1, digest2, "Digests are not randomized."
  end
end
