class EventController < ActionController::Base

    @@event_service = EventService.new

    def create_event
        user_id = params["user_id"]
        group_id = params["group_id"]

        #TODO Make sure group belongs to user

        json_body = JSON.parse(request.body.read)

        user = User.find(user_id)
        group = Group.find(group_id)




    end

end