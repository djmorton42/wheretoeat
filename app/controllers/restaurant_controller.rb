class RestaurantController < ActionController::Base

    def get_restaurants
        user_id = params["user_id"]
        group_id = params["group_id"]

        user = User.find(user_id)
        group = Group.find(group_id)

        #TODO Validate group belongs to user

        render json: group.restaurants.to_json
    end

    def create_restaurant
        user_id = params["user_id"]
        group_id = params["group_id"]

        json_body = JSON.parse(request.body.read)

        Restaurant.transaction do

            begin
                user = User.find(user_id)
                group = Group.find(group_id)

                restaurant = Restaurant.create(name: json_body["name"], address: json_body["address"], victory_count:0)

                group.restaurants << restaurant

                render json: restaurant.to_json
            rescue
                #TODO handle errors
            end

        end
    end

end