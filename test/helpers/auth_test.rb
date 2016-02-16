require 'test_helper'

class AuthTest < ActionView::TestCase
  include Auth

  test "should hash provided password with provided salt to expected value" do
    salt = "00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff"
    expected_hashed_password = "f4d0df59692f58f4bd481dc71540eb9b10299f7a9f9e4025e258fa55bda16155"
    hashed_password = Auth.hash_password("mypassword", salt)

    assert_equal(expected_hashed_password, hashed_password)
  end

  test "validate_password_should_return_false_on_incorrect_length_input" do
    salt = "00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff"
    validation_result = Auth.validate_password("mypassword", salt, "wronglengthhash")

    assert_not(validation_result)
  end

  test "validate_password_should_return_true_on_correct_hash_password_and_salt" do
    stored_hash = "f4d0df59692f58f4bd481dc71540eb9b10299f7a9f9e4025e258fa55bda16155"
    salt = "00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff"
    validation_result = Auth.validate_password("mypassword", salt, stored_hash)

    assert(validation_result)
  end

  test "validate_password_should_return_false_on_incorrect_password_password_and_salt" do
    stored_hash = "f4d0df59692f58f4bd481dc71540eb9b10299f7a9f9e4025e258fa55bda16155"
    salt        = "00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff"
    validation_result = Auth.validate_password("NOTmypassword", salt, stored_hash)

    assert_not(validation_result)
  end

  test "hex_to_bin_is_reversable_with_bin_to_hex" do
    test_hex_value = "abcded0123456789"

    converted_hex_value = Auth.bin_to_hex(Auth.hex_to_bin(test_hex_value))

    assert_equal(test_hex_value, converted_hex_value)
  end
end