module Auth
    ITERATIONS = 1000
    KEY_LENGTH = 32

    def Auth.hash_password(password, salt)
        salt_bytes = salt.kind_of?(String) ? Auth.hex_to_bin(salt) : salt
        Auth.bin_to_hex(
            OpenSSL::PKCS5.pbkdf2_hmac_sha1(
                password,
                salt_bytes,
                ITERATIONS,
                KEY_LENGTH
            )
        )
    end

    def Auth.generate_salt
        OpenSSL::Random.random_bytes(KEY_LENGTH)
    end

    def Auth.generate_salt_string
        Auth.bin_to_hex(Auth.generate_salt)
    end

    def Auth.validate_password(password, salt, stored_hash)
        hashed_password = Auth.hash_password(password, salt)

        return false if hashed_password.length != stored_hash.length

        Auth.non_short_circuit_string_comp(hashed_password, stored_hash)
    end

    def Auth.non_short_circuit_string_comp(first_string, second_string)
        return false if first_string.length != second_string.length
        is_equal = true

        for i in 0 .. first_string.length - 1
            is_equal = false if first_string[i] != second_string[i]
        end
        return is_equal
    end

    def Auth.bin_to_hex(byte_array)
        byte_array.each_byte.map { |byte| byte.to_s(16).rjust(2, '0') }.join
    end

    def Auth.hex_to_bin(hex_string)
        hex_string.scan(/../).map { |char| char.hex.chr }.join
    end
end