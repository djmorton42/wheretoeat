class UserController < ActionController::Base

    @@user_service = UserService.new

    def get_user
        user_id = params["user_id"]

        #TODO validate the logged in user is allowed to see this user

        begin
            user = User.find(user_id)
            render json: user.to_json, status: :ok
        rescue ActiveRecord::RecordNotFound => e
            render text: "User with id #{user_id} could not be found.",
                   status: :not_found
        end
    end

    def create_user
        json_body = JSON.parse(request.body.read)

        begin
            created_user = @@user_service.create_user(json_body)
            render status: :created,
                   location: (request.original_url +
                             ((request.original_url.end_with? "/") ? "" : "/") +
                             created_user["id"].to_s),
                   json: created_user.to_json
        rescue ActiveRecord::RecordNotUnique => e
            render text: "User with specified email already exists",
                   status: :conflict
        rescue RequiredFieldMissingException => e
            render status: :bad_request,
                   text: e.to_s
        end
    end
end