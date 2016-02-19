class RestaurantController < ActionController::Base

    @@restaurant_service = RestaurantService.new

    def get_restaurants
        user_id = params["user_id"]
        group_id = params["group_id"]

        user = User.find(user_id)
        group = Group.find(group_id)

        #TODO Validate group belongs to user

        render json: group.restaurants.to_json
    end

    def get_restaurant
        user_id = params["user_id"]
        group_id = params["group_id"]
        restaurant_id = params["restaurant_id"]

        user = User.find(user_id)
        group = Group.find(group_id)

        #TODO Validate group belongs to user

        begin
            restaurant = Restaurant.find(restaurant_id)
            render json: restaurant.to_json,
                   status: :ok
        rescue ActiveRecord::RecordNotFound => e
            render text: "Restaurant with id #{user_id} could not be found.",
                   status: :not_found
        end

    end

    def create_restaurant
        user_id = params["user_id"]
        group_id = params["group_id"]

        json_body = JSON.parse(request.body.read)

        begin
            restaurant = @@restaurant_service.create_restaurant(json_body, user_id, group_id)

            render json: restaurant.to_json,
                   location: (request.original_url +
                     ((request.original_url.end_with? "/") ? "" : "/") +
                     restaurant["id"].to_s),
                   status: :created
        rescue ActiveRecord::RecordNotUnique => e
            render status: :conflict,
                   text: "Restaurant with specified name already exists in group"
        rescue RequiredFieldMissingException => e
            render status: :bad_request,
                   text: e.to_s
        end
    end

end