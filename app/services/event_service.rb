class EventService
    @@restaurant_url_id_pattern = /.*user\/[0-9]+\/group\/[0-9]\/restaurant\/([0-9]+)/

    def create_event(json_body, user_id, group_id)
        #TODO Make sure group belongs to user

        user = User.find(user_id)
        group = Group.find(group_id)

        voter_emails = json_body["voters"]
        restaurants = json_body["restaurants"]

        Event.transaction do

            event = Event.create(
                title: json_body["title"],
                description: json_body["description"],
                event_datetime: Time.at(json_body["event_datetime"]),
                voting_start_datetime: Time.at(json_body["voting_start_datetime"]),
                voting_end_datetime: Time.at(json_body["voting_end_datetime"]),
                group: group
                )

            event.restaurants += get_restaurant_models restaurants

            voter_models = get_voter_models voter_emails

            event.voters += voter_models

            voter_models.each do |voter_model|
                VoterEventKey.create(
                    event: event,
                    voter: voter_model,
                    key: SecureRandom.uuid)
            end

            return event
        end
    end

    def update_event(json_body, user_id, group_id, event_id)
        Event.transaction do
            user = User.find(user_id)
            group = Group.find(group_id)

            event = Event.find(event_id)

            prior_voter_emails = event.voters.map { |voter| voter.email }
            updated_voter_emails = json_body["voters"]

            emails_to_remove = prior_voter_emails - updated_voter_emails
            emails_to_add = updated_voter_emails - prior_voter_emails

            event.voters.each do |voter|
                if emails_to_remove.include? voter.email
                    event.voters.delete(voter)
                end
            end

            emails_to_add.each { |email| event.voters << Voter.create(email: email) }

            updated_restaurant_ids = json_body["restaurants"].map { |restaurant_url| get_id_from_restaurant_url(restaurant_url) }
            prior_restaurant_ids = event.restaurants.map { |restaurant| restaurant.id }

            restaurant_ids_to_remove = prior_restaurant_ids - updated_restaurant_ids
            restaurant_ids_to_add = updated_restaurant_ids - prior_restaurant_ids

            event.restaurants.each do |restaurant|
                if restaurant_ids_to_remove.include? restaurant.id
                    event.restaurants.delete(restaurant)
                end
            end

            event.restaurants += Restaurant.find(restaurant_ids_to_add)

            event.title = json_body["title"]
            event.description = json_body["description"]
            event.event_datetime = Time.at(json_body["event_datetime"])
            event.voting_start_datetime = Time.at(json_body["voting_start_datetime"])
            event.voting_end_datetime = Time.at(json_body["voting_end_datetime"])

            event.save

            return event
        end
    end

    #TODO Fully implmeent patch
    def patch_event(json_body, user_id, group_id, event_id)
        event = Event.find(event_id)

        json_body.each do |operation_line|
            if operation_line["op"] == "add"
                if operation_line["path"] == "/voters"
                    email_to_add = operation_line["value"]
                    event.voters << Voter.create(email: email_to_add)
                elsif operation_line["path"] == "/restaurants"

                end

            end

        end
    end

    def get_voter_models(voter_emails)
        voter_models = []

        voter_emails.each do |voter_email|
            voter_model = Voter.find_by email: voter_email
            if voter_model
                voter_models << voter_model
            else
                voter_models << Voter.create(email: voter_email)
            end
        end

        return voter_models
    end

    def get_id_from_restaurant_url(restaurant_url)
        if @@restaurant_url_id_pattern =~ restaurant_url
            return $1
        else
            #TODO Throw exception
        end
    end

    def get_restaurant_models(restaurant_urls)
        restaurant_models = []

        restaurant_urls.each do |restaurant_url|
            restaurant_models << Restaurant.find(get_id_from_restaurant_url(restaurant_url))
        end

        return restaurant_models
    end

    def validate_body(json_body)
        if StrUtil.null_or_empty(json_body["title"])
            raise RequiredFieldMissingException, "title field is required"
        end
    end

    private :validate_body, :get_restaurant_models, :get_voter_models
end