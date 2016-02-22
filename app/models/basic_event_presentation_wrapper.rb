class BasicEventPresentationWrapper

    #attr_accessor :event

    def initialize(event)
        @event = event
    end

    def as_json(options={})
        return @event
            .as_json()
            .merge(:restaurants => @event.restaurants.map { |i| i.url})
            .merge(:voters => @event.voters.map { |i| i["email"] })
    end

end