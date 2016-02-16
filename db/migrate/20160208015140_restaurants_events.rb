class RestaurantsEvents < ActiveRecord::Migration
    def change
        create_table :restaurants_events do |t|
            t.belongs_to :restaurant, index: true
            t.belongs_to :event, index: true
        end

        #add_reference :restaurant_event, :restaurant, index: true
        #add_reference :restaurant_event, :event, index: true

        #add_foreign_key :restaurant_event, :restaurant
        #add_foreign_key :restaurant_event, :event
    end
end
