class GroupService
    def create_group(json_body, user_id)
        validate_body(json_body)

        User.transaction do
            begin
                user = User.find(user_id)

                group = Group.create(name: json_body["name"])

                user.groups << group

                return group
            end
        end
    end

    def validate_body(json_body)
        if StrUtil.null_or_empty(json_body["name"])
            raise RequiredFieldMissingException, "name field is required"
        end
    end

end