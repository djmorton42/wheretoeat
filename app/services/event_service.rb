class EventService

    def create_event(json_body, user_id, group_id)
#title
#description
#event_date
#voting_start_datetime
#voting_end_datetime
    end



    def validate_body(json_body)
        if StrUtil.null_or_empty(json_body["title"])
            raise RequiredFieldMissingException, "title field is required"
        end


    end
end