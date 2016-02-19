class EventController < ActionController::Base

    @@event_service = EventService.new

    def create_event
        user_id = params["user_id"]
        group_id = params["group_id"]

        json_body = JSON.parse(request.body.read)

        begin
            event = @@event_service.create_event(json_body, user_id, group_id)

            render status: :created,
                   location: (request.original_url +
                        ((request.original_url.end_with? "/") ? "" : "/") +
                        event["id"].to_s),
                   json: event.to_json
        rescue ActiveRecord::RecordNotFound => e
            render text: "User #{user_id} does not exist",
                   status: :not_found
        rescue RequiredFieldMissingException => e
            render status: :bad_request,
                   text: e.to_s
        end





    end

end