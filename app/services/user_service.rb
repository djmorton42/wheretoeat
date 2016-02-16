class UserService
    def create_user(json_body)

        validate_body(json_body)

        email = json_body["email"]
        password = json_body["password"]

        salt = Auth.generate_salt_string
        hashed_password = Auth.hash_password(password, salt)

        created_user = User.create(
            email: email,
            is_active: true,
            password_hash: hashed_password,
            salt: salt)

        return created_user
    end

    def validate_body(json_body)
        if StrUtil.null_or_empty(json_body["email"])
            raise RequiredFieldMissingException, "email field is required"
        end

        if StrUtil.null_or_empty(json_body["password"])
            raise RequiredFieldMissingException, "password field is required"
        end
    end
end