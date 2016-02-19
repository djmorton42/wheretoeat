class EventService

    def create_event(json_body, user_id, group_id)
#title
#description
#event_date
#voting_start_datetime
#voting_end_datetime

        #TODO Make sure group belongs to user

        user = User.find(user_id)
        group = Group.find(group_id)

        voters = json_body["voters"]

        event = Event.create(
            title: json_body["title"],
            description: json_body["description"],
            event_datetime: Time.at(json_body["event_datetime"]),
            voting_start_datetime: Time.at(json_body["voting_start_datetime"]),
            voting_end_datetime: Time.at(json_body["voting_end_datetime"])
            )



    end



    def validate_body(json_body)
        if StrUtil.null_or_empty(json_body["title"])
            raise RequiredFieldMissingException, "title field is required"
        end


    end
end