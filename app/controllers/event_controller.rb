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
                   json: BasicEventPresentationWrapper.new(event).to_json
        rescue ActiveRecord::RecordNotFound => e
            #TODO handle different kinds of required objects not found
            render text: "User #{user_id} does not exist",
                   status: :not_found
        rescue RequiredFieldMissingException => e
            render status: :bad_request,
                   text: e.to_s
        end
    end

    def get_event
        user_id = params["user_id"]
        group_id = params["group_id"]
        event_id = params["event_id"]

        #TODO Handle 404 if event not found
        event = Event.find(event_id)

        render status: :ok,
               json: BasicEventPresentationWrapper.new(event).to_json
    end

    def update_event
        user_id = params["user_id"]
        group_id = params["group_id"]
        event_id = params["event_id"]

        json_body = JSON.parse(request.body.read)

        begin
            event = @@event_service.update_event(json_body, user_id, group_id, event_id)

            render status: :ok,
                   json: BasicEventPresentationWrapper.new(event).to_json
        rescue RequiredFieldMissingException => e
            render status: :bad_request,
                   text: e.to_s
        end
    end

    #TODO Fully implement patch
    def patch_event
        user_id = params["user_id"]
        group_id = params["group_id"]
        event_id = params["event_id"]

        #TODO Handle 404 if event not found
        event = Event.find(event_id)

        json_body = JSON.parse(request.body.read)

        @@event_service.patch_event(json_body, user_id, group_id, event_id)

        render status: :ok, text: ""
    end

    #TODO: Test to handle when restaurant URL passed to create doesn't exist
end