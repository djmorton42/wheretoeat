class GroupController < ActionController::Base

    @@group_service = GroupService.new

    def get_groups
        render json: Group.all
    end

    def create_group
        user_id = params["user_id"]

        json_body = JSON.parse(request.body.read)

        begin
            group = @@group_service.create_group(json_body, user_id)

            render status: :created,
                   location: (request.original_url +
                        ((request.original_url.end_with? "/") ? "" : "/") +
                        group["id"].to_s),
                   json: group.to_json
        rescue ActiveRecord::RecordNotFound => e
            render text: "User #{user_id} does not exist",
                   status: :not_found
        rescue RequiredFieldMissingException => e
            render status: :bad_request,
                   text: e.to_s
        end
    end
end