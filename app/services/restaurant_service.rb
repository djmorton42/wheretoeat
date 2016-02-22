class RestaurantService
    def create_restaurant(json_body, user_id, group_id)

        validate_body(json_body)

        Restaurant.transaction do
            user = User.find(user_id)
            group = Group.find(group_id)

            restaurant = Restaurant.create(
                name: json_body["name"],
                address: json_body["address"],
                victory_count:0)

            group.restaurants << restaurant

            return restaurant
        end
    end

    def validate_body(json_body)
        if StrUtil.null_or_empty(json_body["name"])
            raise RequiredFieldMissingException, "name field is required"
        end
    end

    private :validate_body
end